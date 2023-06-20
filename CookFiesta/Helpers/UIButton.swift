import UIKit
@IBDesignable
class RoundedButton: UIButton {
     override func prepareForInterfaceBuilder() {
          super.prepareForInterfaceBuilder()
          customizeView()
     }
     override func awakeFromNib() {
          super.awakeFromNib()
          customizeView()
     }
     func customizeView() {
          // round the corners and clip
          layer.cornerRadius = 10
          clipsToBounds = true
//         backgroundColor = .init(red: 252.00, green: 81.00, blue: 133.00, alpha: 1.00)
     }
}
