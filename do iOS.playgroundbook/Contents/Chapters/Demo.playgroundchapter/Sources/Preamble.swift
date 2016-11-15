import UIKit
import PlaygroundSupport


// DataSource
public let defaultReuseIdentifier = "default"

public class Sight: NSObject {
    public let image: UIImage
    public let title: String
    public let details: String
    public init(title: String, image: UIImage, details: String) {
        self.title = title
        self.image = image
        self.details = details
    }
}
public func loadData() -> [Sight] {
    return [
        Sight(title: "Binnenhof", image: #imageLiteral(resourceName:"Binnenhof.jpg"), details: "The Binnenhof is a complex of buildings in the city centre of The Hague, next to the Hofvijver lake. It houses the meeting place of both houses of the States General of the Netherlands, as well as the Ministry of General Affairs and the office of the Prime Minister of the Netherlands. Built primarily in the 13th century, the Gothic castle originally functioned as residence of the counts of Holland and became the political centre of the Dutch Republic in 1584. It is counted among the Top 100 Dutch heritage sites. The Binnenhof is the oldest House of Parliament in the world still in use."),
        Sight(title: "Brouwerij De Molen", image: #imageLiteral(resourceName:"Brouwerij De Molen.jpg"), details: "Brouwerij De Molen is a small brewery, distillery and restaurant in Bodegraven, the Netherlands. The brewery, whose name means The Mill, is in a windmill called De Arkduif, built in 1697.\nDe Molen has participated in joint projects with other breweries such as Mikkeller and De Struise Brouwers. They have also participated in re-creations of historic beer recipes, such as those of the defunct British brewery Barclay Perkins.\n\n"),
        Sight(title: "Dutch cheese markets", image: #imageLiteral(resourceName:"Dutch cheese markets.jpg"), details: "There are five cheese markets operating in the Netherlands.\nDutch cheese farmers traditionally brought their cheeses to the market square in town to sell. Teams of official guild cheese-porters (kaasdragers) carried the farmers' cheese on barrows, which typically weighed about 160 kilograms. Buyers then sampled the cheeses and negotiated a price using a ritual system called handjeklap in which buyers and sellers clap each other's hands and shout prices. Once a price is agreed, the porters carry the cheese to the weighing house (Waag), and scale of their company."),
        Sight(title: "Hofwijck", image: #imageLiteral(resourceName:"Hofwijck.jpg"), details: "Hofwijck is a mansion built for 17th-century politician Constantijn Huygens. It is located in Voorburg on the Vliet canal from Den Haag to Leiden, and its formal address is 2 Westeinde, Voorburg, the Netherlands, but its location today is better known as the Voorburg railway station."),
        Sight(title: "Dom Tower of Utrecht", image: #imageLiteral(resourceName:"Dom Tower of Utrecht.jpg"), details: "The Dom Tower (Cathedral Tower, Dutch: Domtoren) of Utrecht is the tallest church tower in the Netherlands, at 112.5 metres (368 feet) in height, and the Gothic-style tower is the symbol of the city. The tower was part of the Cathedral of Saint Martin, Utrecht, also known as Dom Church, and was built between 1321 and 1382, to a design by John of Hainaut. The cathedral was never fully completed due to lack of money. Since the unfinished nave collapsed in 1674 the Dom tower became a free standing tower.\nThe tower stands at the spot where the city of Utrecht originated almost 2,000 years ago."),
        Sight(title: "Efteling", image: #imageLiteral(resourceName:"Efteling.jpg"), details: "Efteling is a fantasy-themed amusement park in Kaatsheuvel in the Netherlands. The attractions are based on elements from ancient myths and legends, fairy tales, fables, and folklore.\nThe park was opened in 1952. It has since evolved from a nature park with a playground and a Fairy Tale Forest into a full-sized theme park.\nIt is the largest theme park in the Netherlands and one of the oldest theme parks in the world. It is twice as large as the original Disneyland park in California and antedates it by three years."),
        Sight(title: "Eisinga Planetarium", image: #imageLiteral(resourceName:"Eisinga Planetarium.jpg"), details: "The Royal Eise Eisinga Planetarium (Dutch: Koninklijk Eise Eisinga Planetarium) is an 18th-century orrery in Franeker, Friesland, Netherlands. It is currently a museum and open to the public. The orrery has been on the top 100 Dutch heritage sites list since 1990 and in December 2011 was nominated as a UNESCO World Heritage Site candidate. It is the oldest working orrery in the world."),
        Sight(title: "Museum Het Prinsenhof", image: #imageLiteral(resourceName:"Museum Het Prinsenhof.jpg"), details: "The Prinsenhof (\"The Court of the Prince\") in Delft in the Netherlands is an urban palace built in the Middle Ages as a monastery. Later it served as a residence for William the Silent. The building still exists and now houses the municipal museum. William was murdered in the Prinsenhof in 1584; the holes in the wall made by the bullets at the main stairs are still visible.\nToday, the building displays a collection of Dutch Golden Age paintings."),
        Sight(title: "Oosterscheldekering", image: #imageLiteral(resourceName:"Oosterscheldekering.jpg"), details: "The Oosterscheldekering (in English: Eastern Scheldt storm surge barrier), between the islands Schouwen-Duiveland and Noord-Beveland, is the largest of the 13 ambitious Delta Works series of dams and storm surge barriers, designed to protect the Netherlands from flooding from the North Sea. The construction of the Delta Works was in response to the widespread damage and loss of life due to the North Sea Flood of 1953."),
        Sight(title: "Kop van Zuid", image: #imageLiteral(resourceName:"Kop van Zuid.jpg"), details: "Kop van Zuid is a neighborhood of Rotterdam, The Netherlands, located on the south bank of the Nieuwe Maas opposite the center of town.\nThe Kop van Zuid is built on old, abandoned port areas around the Binnenhaven, Entrepothaven, Spoorweghaven, Rijnhaven and the Wilhelmina Pier. These port sites and the Nieuwe Maas made for a large physical distance between the center and north of the Maas and southern Rotterdam."),
        Sight(title: "Het Loo Palace", image: #imageLiteral(resourceName:"Het Loo Palace.jpg"), details: "Het Loo Palace is a palace in Apeldoorn, Netherlands. The symmetrical Dutch Baroque building was designed by Jacob Roman and Johan van Swieten and was built between 1684 and 1686 for stadtholder-king William III and Mary II of England.\nThe palace was a residence of the House of Orange-Nassau from the 17th century until the death of Queen Wilhelmina in 1962."),
        Sight(title: "Koppelpoort", image: #imageLiteral(resourceName:"Koppelpoort.jpg"), details: "The Koppelpoort is a medieval gate in the Dutch town Amersfoort. Completed around 1425, the gate combines land- and water-gates, and is part of the second city wall of Amersfoort, which was constructed between 1380 and 1450."),
        Sight(title: "Muiden Castle", image: #imageLiteral(resourceName:"Muiden Castle.jpg"), details: "Muiden Castle is a castle in the Netherlands, located at the mouth of the Vecht river, some 15 kilometers southeast of Amsterdam, in Muiden, where it flows into what used to be the Zuiderzee. It's one of the better known castles in the Netherlands and has been featured in many television shows set in the Middle Ages."),
        Sight(title: "Panorama Mesdag", image: #imageLiteral(resourceName:"Panorama Mesdag.jpg"), details: "Panorama Mesdag is a panorama by Hendrik Willem Mesdag. Housed in a purpose-built museum in The Hague, the panorama is a cylindrical painting (also known as a Cyclorama) more than 14 metres high and about 40 metres in diameter (120 metres in circumference). From an observation gallery in the centre of the room the cylindrical perspective creates the illusion that the viewer is on a high sand dune overlooking the sea, beaches and village of Scheveningen in the late 19th century. A foreground of fake terrain around the viewing gallery hides the base of the painting and makes the illusion more convincing."),
        Sight(title: "Zaanse Schans", image: #imageLiteral(resourceName:"Zaanse Schans.jpg"), details: "Zaanse Schans is a neighbourhood of Zaandam, near Zaandijk in the Netherlands.\nIt has a collection of well-preserved historic windmills and houses. From 1961 to 1974 old buildings from all over the Zaanstreek (nl) were relocated using lowboy trailers to the area. The Zaans Museum, established in 1994, is located in the Zaanse Schans.\nThe Zaans Museum locates next to the Zaanse Schans. The Zaanse Schans houses seven museums: The Weavers House, the Cooperage, the Jisper House, Zaan Time Museum, Albert Heijn Museumshop, Bakery Museum.")
    ]

}

extension Sight: UIActivityItemSource {
    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return image
    }
    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        return image
    }
    public func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        return title
    }
    public func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return image
    }
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
        imageView.contentMode = .scaleAspectFill
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
    public typealias ConfiguredType = Sight
    public func configure(for item: Sight) {
        imageView.image = item.image
    }
}

public class SightDataSource {
    public var data: [Sight]

    public init() {
        self.data = loadData()
    }
}
extension SightDataSource: CollectionViewCellConfiguring {
    public typealias CollectionCellType = CollectionViewCell
}
extension SightDataSource: DataContaining {}
extension SightDataSource: CollectionViewDataSource {}


public class SightListDataSource: CollectionViewDataSourceProxy {
    private let sightDataSource: SightDataSource
    public var data: [Sight] {
        get {
            return sightDataSource.data
        }
        set {
            sightDataSource.data = newValue
        }

    }
    public init() {
        self.sightDataSource = SightDataSource()
        super.init(dataSource: self.sightDataSource)
    }
}
extension SightListDataSource: MutableDataContaining {}
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
public let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 200, height: 200)
    layout.minimumLineSpacing = 10
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    return layout
}()

// ViewControllers
import UIKit

public class SightViewController: UIViewController {
    let sight: Sight
    var imageView: UIImageView? = nil
    var label: UILabel? = nil
    public var didTapShareButton: ((UIBarButtonItem) -> Void)?
    public init(sight: Sight) {
        self.sight = sight
        super.init(nibName: nil, bundle: nil)
        self.title = sight.title
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func loadView() {
        super.loadView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        let imageView = UIImageView(image: sight.image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        self.imageView = imageView
        let label = UILabel()
        label.numberOfLines = 0
        label.text = sight.details
        view.addSubview(label)
        self.label = label
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageFrame = CGRect(x: 0, y: 44, width: view.frame.width, height: view.frame.width * 0.6)
        imageView?.frame = imageFrame
        let margin: CGFloat = 20
        let textFrame = CGRect(x: margin,
                               y: imageFrame.maxY + margin,
                               width: view.frame.width - margin * 2,
                               height: view.frame.height - imageFrame.maxY - margin)
        if let label = label {
            var textRect = label.textRect(forBounds: textFrame, limitedToNumberOfLines: 0)
            textRect.size.height = min(textFrame.height, textRect.height)
            textRect.origin.y = max(textFrame.origin.y, textRect.origin.y)
            label.frame = textRect
        }
    }

    public func share(_ sender: UIBarButtonItem) {
        didTapShareButton?(sender)
    }

}
