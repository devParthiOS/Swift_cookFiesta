//
//  File.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 21/03/23.
//

import Foundation
import UIKit
@IBDesignable
class SearchBar : UITextField {
    var icon : UIImageView!
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
        textColor = .white
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        layer.borderColor = UIColor.white.cgColor
        //         backgroundColor = .init(red: 252.00, green: 81.00, blue: 133.00, alpha: 1.00)
//        icon = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25)))
//        icon.image = UIImage(named: "magnifier")
//        self.leftView = icon
//        self.rightViewMode = .always
    }
}


