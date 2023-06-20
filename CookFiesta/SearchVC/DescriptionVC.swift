//
//  DescriptionVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 27/03/23.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class DescriptionVC: UIViewController {
    @IBOutlet weak var bgImg: UIImageView!
    var imgUrl : URL! = nil
    var child : String! = nil
    var ref = Database.database().reference()
    var databucket : [DescriptionDetail] = []

    @IBOutlet weak var descriptionTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        snapShotData()
//        bgImg.sd_setImage(with: imgUrl)
    }
    
    func snapShotData() {
        self.databucket.removeAll()
        ref.child("Description").child(child!).observe(.childAdded) { snapshot in
            let key = snapshot.key
            print(key)
            guard let value = snapshot.value as? [String : Any] else {return}
            if let type = value["Type"] as? String , let recipe = value["Recipe"] as? String {
                let detail = DescriptionDetail(index: key, type: type, recipe: recipe)
                    self.databucket.append(detail)

            }
            DispatchQueue.main.async {
                self.descriptionTV.reloadData()
            }
        }
    }

    
    


}

extension DescriptionVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databucket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = descriptionTV.dequeueReusableCell(withIdentifier: "DescriptionTVC", for: indexPath) as! DescriptionTVC
        cell.descriptionView.layer.cornerRadius = 10
        cell.descriptionView.layer.borderColor = UIColor.white.cgColor
        cell.descriptionView.layer.borderWidth = 2
        cell.detailTextView.layer.cornerRadius = 10
        cell.detailTextView.layer.borderWidth = 1
        cell.btnShare.layer.cornerRadius = 10
//        cell.detailTextView.sizeToFit()
        cell.selectionStyle = .none
        cell.typeFoodLbl.text = databucket[indexPath.row].type
        cell.detailTextView.text = databucket[indexPath.row].recipe
        
        
        return cell
    }
    
    
}
