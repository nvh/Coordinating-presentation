import UIKit
import PlaygroundSupport

protocol Coordinating: class {
    associatedtype RootViewController: UIViewController
    associatedtype ViewController: UIViewController
    var root: RootViewController { get }
    var viewController: ViewController? { get set }
    func createViewController() -> ViewController
    func configure(_ viewController: ViewController)
    func show(_ viewController: ViewController)
    func dismiss()
}
extension Coordinating {
    func start() {
        let vc = createViewController()
        viewController = vc
        configure(vc)
        show(vc)
    }
    func stop() {
        dismiss()
        viewController = nil
    }
}

extension Coordinating {
    func configure(_ viewController: ViewController) {
    }
    func show(_ viewController: ViewController) {
        root.present(viewController, animated: true , completion: nil)
    }
    func dismiss() {
        root.dismiss(animated: true, completion: nil)
    }
}
protocol NavigationCoordinating: Coordinating {
    typealias RootViewController = UINavigationController
}
extension NavigationCoordinating {
    func show(_ viewController: Self.ViewController) {
        root.pushViewController(viewController, animated: true)
    }
    func dismiss() {
        root.dismiss(animated: true, completion: nil)
    }
}
protocol PopoverCoordinating: Coordinating {
    var barButtonItem: UIBarButtonItem? { get }
}
extension PopoverCoordinating {
    func show(_ viewController: Self.ViewController) {
        viewController.popoverPresentationController?.barButtonItem = barButtonItem
        root.present(viewController, animated: true, completion: nil)
    }
}
class PhotoCollectionCoordinator: NSObject, NavigationCoordinating, Editing, Sharing, ImagePicking {
    var dataSource = PhotoListDataSource(data: loadData())
    
    let root: UINavigationController
    var viewController: PhotoCollectionViewController?
    var imageCoordinator: ImageCoordinator?
    var imagePickerCoordinator: ImagePickerCoordinator?
    var shareCoordinator: ShareCoordinator<UIImage>?
    var sharedItems: [UIImage] {
        return viewController?.collectionView?.indexPathsForSelectedItems?.map({$0.item
        }).flatMap(dataSource.item(at:)) ?? []
    }
    init(root: UINavigationController) {
        self.root = root
        dataSource.insert(#imageLiteral(resourceName: "AddButton.png"), at: dataSource.numberOfItems)
    }
    func createViewController() -> PhotoCollectionViewController {
        return PhotoCollectionViewController(collectionViewLayout: photoLayout)
    }
    func configure(_ viewController: PhotoCollectionViewController) {
        viewController.collectionView?.dataSource = dataSource
        viewController.collectionView?.delegate = self
        viewController.navigationItem.rightBarButtonItem = editButton
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    }
    func share(_ sender: AnyObject) {
        didTapShareButton(sender)
    }
    
    func didShare() {
        editing = false
    }
    
    var editing = false {
        didSet {
            if editing {
                viewController?.navigationItem.rightBarButtonItem = doneButton
                viewController?.collectionView?.allowsMultipleSelection = true
            } else {
                viewController?.navigationItem.rightBarButtonItem = editButton
                viewController?.collectionView?.allowsMultipleSelection = false
                for indexPath in viewController?.collectionView?.indexPathsForSelectedItems ?? [] {
                    viewController?.collectionView?.deselectItem(at: indexPath, animated: false)
                }
            }
        }
    }
    public func edit(_ sender: AnyObject) {
        editing = true
    }
    public func doneEditing(_ sender: AnyObject) {
        editing = false
    }
    func didPickImage(image: UIImage) {
        dataSource.insert(image, at: 0)
        viewController?.collectionView?.insertItems(at: [IndexPath(item: 0, section: 0)])
    }
}
extension PhotoCollectionCoordinator: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != dataSource.numberOfItems - 1 else {
            collectionView.deselectItem(at: indexPath, animated: false)
            pickImage()
            return
        }
        guard !editing else { return }
        guard let item = dataSource.item(at: indexPath.item) else { return }
        imageCoordinator = ImageCoordinator(root: root, image: item)
        imageCoordinator?.start()
    }
}

class ImageCoordinator: NavigationCoordinating, Sharing {
    let root: UINavigationController
    var viewController: ImageViewController?
    let image: UIImage
    var sharedItems: [UIImage] {
        return [image]
    }
    var shareCoordinator: ShareCoordinator<UIImage>?
    init(root: UINavigationController, image: UIImage) {
        self.root = root
        self.image = image
    }
    func createViewController() -> ImageViewController {
        return ImageViewController(image:  image)
    }
    func configure(_ viewController: ImageViewController) {
        viewController.didTapShareButton = didTapShareButton
    }
    
    
}

public class PhotoCollectionViewController: UICollectionViewController {
    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShareCoordinator<SharedType: AnyObject>: PopoverCoordinating {
    var barButtonItem: UIBarButtonItem?
    let root: UIViewController
    var viewController: UIActivityViewController?
    let sharedItems: [SharedType]
    var completionHandler: (() -> Void)?
    init(root: UIViewController, sharedItems: [SharedType]) {
        self.root = root
        self.sharedItems = sharedItems
    }
    func createViewController() -> UIActivityViewController {
        return UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
    }
    func configure(_ viewController: UIActivityViewController) {
        viewController.completionWithItemsHandler = { _  in
            self.completionHandler?()
            
        }
    }
    
}
protocol Sharing: class {
    associatedtype SharedType: AnyObject
    var sharedItems: [SharedType] { get }
    var shareCoordinator: ShareCoordinator<SharedType>? { get set }
    func didTapShareButton(_ sender: AnyObject)
    func didShare()
}
extension Sharing where Self: Coordinating {
    func didTapShareButton(_ sender: AnyObject) {
        shareCoordinator = ShareCoordinator(root: root, sharedItems: sharedItems)
        shareCoordinator?.barButtonItem = sender as? UIBarButtonItem
        shareCoordinator?.completionHandler = didShare
        shareCoordinator?.start()
    }
    func didShare() {
        shareCoordinator?.stop()
        shareCoordinator = nil
    }
}

class ImagePickerCoordinator: NSObject, Coordinating {
    let root: UIViewController
    var viewController: UIImagePickerController?
    var didComplete: (UIImage?) -> Void
    init(root: UIViewController, didComplete: @escaping (UIImage?) -> Void) {
        self.root = root
        self.didComplete = didComplete
    }
    func createViewController() -> UIImagePickerController {
        return UIImagePickerController()
    }
    func configure(_ viewController: UIImagePickerController) {
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        
    }
}
extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        didComplete(nil)
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            didComplete(image)
            return
        }
        didComplete(nil)
    }
}
protocol ImagePicking: class {
    var imagePickerCoordinator: ImagePickerCoordinator? { get set }
    func pickImage()
    func didPickImage(image: UIImage)
}
extension ImagePicking where Self: Coordinating {
    func pickImage() {
        imagePickerCoordinator = ImagePickerCoordinator(root: root , didComplete: didComplete)
        imagePickerCoordinator?.start()
    }
    func didComplete(image: UIImage?) {
        imagePickerCoordinator?.stop()
        imagePickerCoordinator = nil
        if let image = image {
            didPickImage(image:  image)
        }
    }
}


let nav = UINavigationController()
let root = PhotoCollectionCoordinator(root: nav)
PlaygroundPage.current.liveView = nav
PlaygroundPage.current.needsIndefiniteExecution = true
root.start()
