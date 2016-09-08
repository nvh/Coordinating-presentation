import UIKit
import PlaygroundSupport

// DataSource
public let defaultReuseIdentifier = "default"

public func loadData() -> [UIImage] {
    return [#imageLiteral(resourceName: "alex.jpg"),#imageLiteral(resourceName: "dominik.png"),#imageLiteral(resourceName: "greg.jpg"),#imageLiteral(resourceName: "ian.jpg"),#imageLiteral(resourceName: "jens.jpg"),#imageLiteral(resourceName: "manu.png"),#imageLiteral(resourceName: "matheusz.jpg"),#imageLiteral(resourceName: "sam.jpg"),#imageLiteral(resourceName: "stuff.jpg"),#imageLiteral(resourceName: "zeyad.jpg")]
}

public protocol DataContaining {
    associatedtype ItemType
    var data: [ItemType] { get }
}

public extension DataContaining {
    var numberOfItems: Int {
        return data.count
    }
    
    func item(at index: Int) -> ItemType? {
        guard index < numberOfItems else {
            return nil
        }
        return data[index]
    }
}

extension Array: DataContaining {
    public typealias ItemType = Element
    public var data: [ItemType] {
        return self
    }
}

public protocol MutableDataContaining: DataContaining {
    var data: [ItemType] { get set }
}

public extension MutableDataContaining {
    mutating func insert(_ item: ItemType, at index: Int) {
        data.insert(item, at: index)
    }
}

public protocol Configurable {
    associatedtype ConfiguredType
    func configure(for item: ConfiguredType)
}

public protocol CollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
    
    mutating func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

// Sections
public extension CollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// Moving
public extension CollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    mutating func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
}


extension CollectionViewDataSource where Self: DataContaining, Self: CollectionViewCellConfiguring, Self.ItemType == Self.CollectionCellType.ConfiguredType {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseIdentifier, for: indexPath)
        if let item = item(at: indexPath.item), let cell = cell as? CollectionCellType {
            cell.configure(for: item)
        }
        return cell
    }
}

public protocol CollectionViewCellConfiguring {
    associatedtype CollectionCellType: Configurable
}

public class CollectionViewDataSourceProxy: NSObject, UICollectionViewDataSource {
    var dataSource: CollectionViewDataSource
    
    public init(dataSource: CollectionViewDataSource) {
        self.dataSource = dataSource
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections(in: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return dataSource.collectionView(collectionView, canMoveItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource.collectionView(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
}

public class CollectionViewCell: UICollectionViewCell {
    public var imageView: UIImageView!
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRect(x: 1, y: 1, width: frame.width - 2, height: frame.width - 2))
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        selectedBackgroundView = UIView(frame: frame)
        selectedBackgroundView?.layer.cornerRadius = 4
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCell: Configurable {
    public typealias ConfiguredType = UIImage
    public func configure(for item: UIImage) {
        imageView.image = item
    }
}

public class ImageDataSource {
    public var data: [UIImage]
    
    public init(data: [UIImage]) {
        self.data = data
    }
}
extension ImageDataSource: CollectionViewCellConfiguring {
    public typealias CollectionCellType = CollectionViewCell
}
extension ImageDataSource: DataContaining {}
extension ImageDataSource: CollectionViewDataSource {}


public class PhotoListDataSource: CollectionViewDataSourceProxy {
    private let imageDataSource: ImageDataSource
    public var data: [UIImage] {
        get {
            return imageDataSource.data
        }
        set {
            imageDataSource.data = newValue
        }
        
    }
    public init(data: [UIImage]) {
        self.imageDataSource = ImageDataSource(data: data)
        super.init(dataSource: imageDataSource)
    }
}
extension PhotoListDataSource: MutableDataContaining {}
// Editing

@objc public protocol EditingObjC {
    @objc func edit(_ sender: AnyObject)
    @objc func doneEditing(_ sender: AnyObject)
}

public protocol Editing: EditingObjC {
    var editing: Bool { get set }
    var editButton: UIBarButtonItem { get }
    var doneButton: UIBarButtonItem { get }
}

public extension Editing {
    public var editButton: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(EditingObjC.edit(_:)))
    }
    public var doneButton: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(EditingObjC.doneEditing(_:)))
    }
}
// TapGesture

public class TapGesture: NSObject {
    let closure: ()-> Void
    public init(on view: UIView
        ,closure: @escaping ()-> Void) {
        self.closure = closure
        super.init()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(action(_:))))
    }
    @objc func action(_ sender: AnyObject) { closure() }
}
// Utils
public let photoLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 200, height: 200)
    layout.minimumLineSpacing = 10
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    return layout
}()

// ViewControllers
import UIKit

public class ImageViewController: UIViewController {
    let image: UIImage
    var imageView: UIImageView? = nil
    public var didTapShareButton: ((UIBarButtonItem) -> Void)?
    public init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func loadView() {
        super.loadView()
        view.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        self.imageView = imageView
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView?.frame = view.frame
    }
    
    public func share(_ sender: UIBarButtonItem) {
        didTapShareButton?(sender)
    }
    
}