//
//  PostTVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 03/04/23.
//

import UIKit

class PostTVC: UITableViewCell {

    @IBOutlet weak var btnProperty: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
