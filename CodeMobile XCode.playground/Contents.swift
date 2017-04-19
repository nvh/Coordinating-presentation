import UIKit
import PlaygroundSupport

protocol Coordinating: class {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get set }
    var root: UIViewController { get }
    func createViewController() -> ViewController
    func configure(vc: ViewController)
    func show(vc: ViewController)
}
extension Coordinating {
    func configure(vc: ViewController) {
    }
    func show(vc: ViewController) {
        root.show(vc, sender: self)
    }
    func dismiss() {
        root.dismiss(animated: true, completion: nil)
    }
}
extension Coordinating {
    func start() {
        let vc = createViewController()
        self.viewController = vc
        configure(vc: vc)
        show(vc: vc)
    }
    func stop() {
        dismiss()
        self.viewController = nil
    }
}
protocol PopopoverCoordinating: Coordinating {
    var barButtonItem: UIBarButtonItem? { get }
}
extension PopopoverCoordinating {
    func show(vc: ViewController) {
        vc.popoverPresentationController?.barButtonItem = barButtonItem
        root.present(vc, animated: true, completion: nil)
    }
}
/*:
 ### Coordinators
 */
class JourneyCoordinator: Coordinating, Sharing, Editing {
    let dataSource = SightListDataSource()

    var viewController: JourneyCollectionViewController?
    let root: UIViewController

    var sightCoordinator: SightCoordinator?

    //Sharing
    var shareCoordinator: ShareCoordinator<Sight>?
    var sharedItems: [Sight] {
        return viewController?.collectionView?.indexPathsForSelectedItems?.map({$0.item}
            ).flatMap(dataSource.item(at:)) ?? []
    }

    init(root: UIViewController) {
        self.root = root
    }
    func createViewController() -> JourneyCollectionViewController {
        return JourneyCollectionViewController(collectionViewLayout: layout)
    }
    func configure(vc: JourneyCollectionViewController) {
        vc.collectionView?.dataSource = dataSource
        vc.didSelectItem = didSelectItem(at:)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
        vc.navigationItem.rightBarButtonItem = editButton
    }
    @objc func share(_ sender: UIBarButtonItem) {
        didTapShareButton(sender)
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard
            !editing, let item = dataSource.item(at: indexPath.item)
            else { return }
        self.sightCoordinator = SightCoordinator(root: root, sight: item)
        self.sightCoordinator?.start()
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

}
class SightCoordinator: Coordinating, Sharing {
    var viewController: SightViewController?
    let root: UIViewController
    let sight: Sight

    var shareCoordinator: ShareCoordinator<Sight>?
    var sharedItems: [Sight] {
        return [sight]
    }

    init(root: UIViewController, sight: Sight) {
        self.root = root
        self.sight = sight
    }
    func createViewController() -> SightViewController {
        return SightViewController(sight: sight)
    }
    func configure(vc: SightViewController) {
        vc.didTapShareButton = didTapShareButton(_:)
    }
}

class ShareCoordinator<SharedType>: PopopoverCoordinating {
    var barButtonItem: UIBarButtonItem?
    var viewController: UIActivityViewController?
    let root: UIViewController
    let sharedItems: [SharedType]
    var completionHandler: (() -> Void)?

    init(root: UIViewController, sharedItems: [SharedType]) {
        self.root = root
        self.sharedItems = sharedItems
    }
    func createViewController() -> UIActivityViewController {
        return UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
    }
    func configure(vc: UIActivityViewController) {
        vc.completionWithItemsHandler = { [weak self] _ in
            self?.completionHandler?()
        }
    }
}
/*:
 ### ViewControllers
 */
public class JourneyCollectionViewController: UICollectionViewController {
    var didSelectItem: ((IndexPath) -> Void)?
    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
        collectionView?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.title = "Epic Journey through the Netherlands"
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
}
/*:
 ### Sharing
 */
protocol Sharing: class {
    associatedtype SharedType
    var shareCoordinator: ShareCoordinator<SharedType>? { get set }
    var sharedItems: [SharedType] { get }
    func didTapShareButton(_ sender: UIBarButtonItem)
    func didShare()
}
extension Sharing where Self: Coordinating {
    func didTapShareButton(_ sender: UIBarButtonItem) {
        self.shareCoordinator = ShareCoordinator(root: root, sharedItems: sharedItems)
        self.shareCoordinator?.barButtonItem = sender
        self.shareCoordinator?.completionHandler = didCompleteShare
        self.shareCoordinator?.start()
    }
    func didCompleteShare() {
        self.shareCoordinator?.stop()
        self.shareCoordinator = nil
        didShare()
    }
    func didShare() {
        
    }
}

/*:
 ### Setup
 */
let nav = UINavigationController()
let mainCoordinator = JourneyCoordinator(root: nav)
PlaygroundPage.current.liveView = nav
mainCoordinator.start()