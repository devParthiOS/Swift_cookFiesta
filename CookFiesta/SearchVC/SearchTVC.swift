//
//  SearchTVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 21/03/23.
//

import UIKit
import SDWebImage

class SearchTVC: UITableViewCell {

    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var foodLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
