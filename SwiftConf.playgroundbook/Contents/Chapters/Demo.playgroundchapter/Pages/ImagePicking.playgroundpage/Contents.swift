//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
public class ImagePickerCoordinator: NSObject, Coordinating {
    public typealias VC = UIImagePickerController
    public let root: UIViewController
    public var viewController: UIImagePickerController?
    
    var pickingComplete: ((UIImage?) -> Void)?
    
    public init(root: UIViewController) {
        self.root = root
    }
    
    public func createViewController() -> UIImagePickerController {
        return UIImagePickerController()
    }
    
    public func configure(vc: UIImagePickerController) {
        vc.sourceType = .savedPhotosAlbum
        vc.delegate = self
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        pickingComplete?(image)
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickingComplete?(nil)
    }
}

protocol ImagePicking: class {
    var imagePickerCoordinator: ImagePickerCoordinator? { get set }
    func pickImage()
    func didPick(image: UIImage)
}

extension ImagePicking where Self: Coordinating {
    func pickImage() {
        let picker = ImagePickerCoordinator(root: root)
        picker.pickingComplete = pickingComplete(image:)
        imagePickerCoordinator = picker
        picker.start()
    }
    
    func pickingComplete(image: UIImage?) {
        imagePickerCoordinator?.stop()
        imagePickerCoordinator = nil
        if let image = image {
            didPick(image: image)
        }
    }
}