//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
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