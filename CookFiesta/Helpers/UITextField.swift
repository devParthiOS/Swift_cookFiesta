import UIKit
@IBDesignable
class CustomTxtField : UITextField {
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
         layer.borderWidth = 1
         textColor = .white
         attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
         )
         layer.borderColor = UIColor.white.cgColor
//         backgroundColor = .init(red: 252.00, green: 81.00, blue: 133.00, alpha: 1.00)
     }
}
