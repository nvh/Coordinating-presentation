//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
let imageView = UIImageView()
imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
var images: IndexingIterator<[UIImage]> = [#imageLiteral(resourceName: "Framer.png"),#imageLiteral(resourceName: "CocoaHeadsNL.png")].makeIterator()
imageView.contentMode = .scaleAspectFit
imageView.isUserInteractionEnabled = true
let t1 = TapGesture(on: imageView) {
    imageView.image = images.next()
}
import PlaygroundSupport
imageView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
PlaygroundPage.current.liveView = imageView
PlaygroundPage.current.needsIndefiniteExecution = true