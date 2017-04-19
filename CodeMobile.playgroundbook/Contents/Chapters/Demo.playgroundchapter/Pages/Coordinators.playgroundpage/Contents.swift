//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
/*:
 ### Coordinating
 */

/*:
 ### Coordinators
 */

/*:
 ### ViewControllers
 */
public class JourneyCollectionViewController: UICollectionViewController {
    let dataSource = SightListDataSource()

    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
        collectionView?.dataSource = dataSource
        collectionView?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.title = "Epic Journey through the Netherlands"
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.item(at: indexPath.item) else { return }
        let viewController = SightViewController(sight: item)
        self.navigationController?.show(viewController, sender: self)
    }
}
/*:
 ### Sharing
 */

/*:
 ### Setup
 */
let viewController = JourneyCollectionViewController(collectionViewLayout: layout)
let nav = UINavigationController(rootViewController: viewController)
PlaygroundPage.current.liveView = nav
