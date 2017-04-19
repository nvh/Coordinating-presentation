//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code
let label = UILabel()
label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
var emojis = ["🇳🇱","❌❌❌","🗺"].makeIterator()
label.textAlignment = .center
label.font = UIFont.systemFont(ofSize: 150)
label.isUserInteractionEnabled = true
let t2 = TapGesture(on: label) {
    label.text = emojis.next()
}
import PlaygroundSupport
label.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
PlaygroundPage.current.liveView = label
PlaygroundPage.current.needsIndefiniteExecution = true
