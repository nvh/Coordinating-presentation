import UIKit
import PlaygroundSupport

protocol Coordinating: class {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get set }
    var root: UIViewController { get }
    func createViewController() -> ViewController
    func configure(vc: ViewController)
    func show(vc: ViewController)
    func dismiss()
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
        configure(vc: vc)
        show(vc: vc)
        self.viewController = vc
    }
    func stop() {
        dismiss()
        self.viewController = nil
    }
}

protocol PopoverCoordinating: Coordinating {
    var barButtonItem: UIBarButtonItem? { get set }
}
extension PopoverCoordinating {
    func show(vc: ViewController) {
        vc.popoverPresentationController?.barButtonItem = barButtonItem
        root.present(vc, animated: true, completion: nil)
    }
}
/*:
 ### Coordinators
 */
class JourneyCoordinator: Coordinating, Sharing {
    var viewController: JourneyCollectionViewController?
    let root: UIViewController

    let dataSource = SightListDataSource()

    var sightCoordinator: SightCoordinator?

    var sharedItems: [Sight] {
        return dataSource.data
    }
    var shareCoordinator: ShareCoordinator<Sight>?

    init(root: UIViewController) {
        self.root = root
    }
    func createViewController() -> JourneyCollectionViewController {
        return JourneyCollectionViewController(collectionViewLayout: layout)
    }

    func configure(vc: JourneyCollectionViewController) {
        vc.collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
        vc.collectionView?.dataSource = dataSource
        vc.didSelectItem = didSelectItem
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))

    }

    @objc func share(_ sender: UIBarButtonItem) {
        didTapShareButton(sender)
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard let item = dataSource.item(at: indexPath.item) else { return }
        sightCoordinator = SightCoordinator(root: root, sight: item)
        sightCoordinator?.start()
    }
}

class SightCoordinator: Coordinating, Sharing {
    var viewController: SightViewController?
    let root: UIViewController
    let sight: Sight

    var sharedItems: [Sight] {
        return [sight]
    }
    var shareCoordinator: ShareCoordinator<Sight>?

    init(root: UIViewController, sight: Sight) {
        self.root = root
        self.sight = sight
    }
    func createViewController() -> SightViewController {
        return SightViewController(sight: sight)
    }
    func configure(vc: SightViewController) {
        vc.didTapShareButton = didTapShareButton
    }
}

class ShareCoordinator<SharedType>: PopoverCoordinating {
    var barButtonItem: UIBarButtonItem?
    var viewController: UIActivityViewController?
    let root: UIViewController
    let sharedItems: [SharedType]
    var completionHandler: ((Void) -> Void)?
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
    var sharedItems: [SharedType] { get }
    var shareCoordinator: ShareCoordinator<SharedType>? { get set }
    func didTapShareButton(_ sender: UIBarButtonItem)
    func didShare()
}
extension Sharing where Self: Coordinating {
    func didTapShareButton(_ sender: UIBarButtonItem) {
        shareCoordinator = ShareCoordinator(root: root, sharedItems: sharedItems)
        shareCoordinator?.barButtonItem = sender
        shareCoordinator?.completionHandler = didShare
        shareCoordinator?.start()
    }

    func didShare() {
        shareCoordinator?.stop()
        shareCoordinator = nil
    }
}
/*:
 ### Setup
 */
let nav = UINavigationController()
let coordinator = JourneyCoordinator(root: nav)
PlaygroundPage.current.liveView = nav
coordinator.start()

