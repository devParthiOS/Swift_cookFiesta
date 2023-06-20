//
//  DescriptionTVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 27/03/23.
//

import UIKit

class DescriptionTVC: UITableViewCell {

   
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var typeFoodLbl: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var btnShare: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
