//
//  PostDescriptionVCViewController.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 03/04/23.
//

import UIKit

class PostDescriptionVC: UIViewController {
    var data : String?
    var imgData : URL?
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDescription.layer.borderColor = UIColor.white.cgColor
        lblDescription.layer.borderWidth = 1
        lblDescription.layer.cornerRadius = 10
        lblDescription.isEditable = false
        lblDescription.text = data
        imgBackground.sd_setImage(with: imgData)
    }
    

    @IBAction func btnLike(_ sender: UIButton) {
        if btnLike.isSelected == false{
            btnLike.isSelected = true
        }
        else {
            btnLike.isSelected = false
        }
        
    }
    
}
