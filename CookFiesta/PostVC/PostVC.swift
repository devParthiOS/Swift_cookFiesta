//
//  PostVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 21/03/23.
//

import UIKit
import SDWebImage

// Import Firebase Storage module
import FirebaseStorage
import FirebaseDatabase

class PostVC: UIViewController {

    var indexPath : Int = 0
    var ref = Database.database().reference()
    let userUid = UserDefaults.standard.string(forKey: "User_Uid")
    var databucket : [ProfileData] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapShotData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostToDetail"{
            if let vc = segue.destination as? PostDescriptionVC
            {
                 vc.data = databucket[indexPath].description
                vc.imgData = URL(string: databucket[indexPath].image)
             }
        }
    }
    
    func snapShotData() {
        databucket.removeAll()
        ref.child("UsersPost").observe(.childAdded) { snapshot in
            let key = snapshot.key
            print(key)
            guard let value = snapshot.value as? [String : Any] else {return}
            if let Name = value["Name"] as? String , let Description = value["Description"] , let UserUid = value["userUid"] as? String , let Image = value["Image"] {
                let detail = ProfileData(index: key, name: Name, description: Description as! String, userUid: UserUid, image: Image as! String)
               
                    self.databucket.append(detail)
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

  
}

extension PostVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databucket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTVC", for: indexPath) as! PostTVC
        cell.selectionStyle = .none
        let base = databucket[indexPath.row]
        cell.imgPost.sd_setImage(with: URL(string: base.image)  , placeholderImage: UIImage(named: "logo"))
        cell.lblDescription.text = base.description
        cell.lblName.text = base.name
        cell.btnProperty.isUserInteractionEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
        performSegue(withIdentifier: "PostToDetail", sender: self)
      
    }
    
}
