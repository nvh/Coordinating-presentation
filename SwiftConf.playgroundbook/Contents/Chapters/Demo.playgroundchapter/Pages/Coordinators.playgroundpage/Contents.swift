//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
public class PhotoCollectionViewController: UICollectionViewController {
    let dataSource = PhotoListDataSource(data: loadData())
    
    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
        collectionView?.dataSource = dataSource
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.item(at: indexPath.item) else { return }
        let viewController = ImageViewController(image: item)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

let nav = UINavigationController(rootViewController: PhotoCollectionViewController(collectionViewLayout: photoLayout))


PlaygroundPage.current.liveView = nav