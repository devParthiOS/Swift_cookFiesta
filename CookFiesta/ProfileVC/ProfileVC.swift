//
//  ProfileVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 21/03/23.
//

import UIKit
import FirebaseAuth
import SDWebImage
import FirebaseDatabase

class ProfileVC: UIViewController {
    var ref = Database.database().reference()
    let userUid = UserDefaults.standard.string(forKey: "User_Uid")
    var databucket : [ProfileData] = []
    var indexpath = 0
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var recipeCount: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subDetailView: UIView!
    @IBOutlet weak var profileBackgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        snapShotData()
        SetupProfile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileToDetail"{
            if let vc = segue.destination as? PostDescriptionVC {
                vc.data = databucket[indexpath].description
                vc.imgData = URL(string: databucket[indexpath].image)
            }
        }
    }
    
    //    MARk :- ProfileDataCall
    
    func snapShotData() {
        databucket.removeAll()
        ref.child("UsersPost").observe(.childAdded) { snapshot in
            let key = snapshot.key
            print(key)
            guard let value = snapshot.value as? [String : Any] else {return}
            if let Name = value["Name"] as? String , let Description = value["Description"] , let UserUid = value["userUid"] as? String , let Image = value["Image"] {
                let detail = ProfileData(index: key, name: Name, description: Description as! String, userUid: UserUid, image: Image as! String)
                if detail.userUid == self.userUid{
                    self.databucket.append(detail)
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func SetupProfile(){
        
        profileBackgroundView.addshadow(cornerRadius: 15, shadowOpacity: 0.2, shadowColor: UIColor.black.cgColor, shadowOffset:CGSize(width: 0, height: 2) , shadowRadius: 5)
        subDetailView
            .addshadow(cornerRadius: 15, shadowOpacity: 0.2, shadowColor: UIColor.black.cgColor, shadowOffset:CGSize(width: 0, height: 2) , shadowRadius: 5)
    }
    
    @IBAction func LogoutBtn(_ sender: UIButton) {
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "IsLoggedin")
            UserDefaults.standard.removeObject(forKey: "User_Uid")
            UserDefaults.standard.removeObject(forKey: "User_Email")
            let st = UIStoryboard(name: "Main", bundle: nil)
            let nextVc = st.instantiateViewController(withIdentifier: "LoginVC")
            let Nv = UINavigationController(rootViewController: nextVc)
            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = Nv
        }
        catch  {
            print(error.localizedDescription)
        }
    }
    
}


extension ProfileVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipeCount.text = "\(databucket.count)"
        return databucket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCVC", for: indexPath) as! ProfileCVC
        cell.lblName.text = databucket[indexPath.row].name
        cell.ImgPost.sd_setImage(with: URL(string: databucket[indexPath.row].image), placeholderImage: UIImage(named: "logo"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: width/2, height: width/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexpath = indexPath.row
        performSegue(withIdentifier: "ProfileToDetail", sender: self)
    }
}







extension UIView {
    
    func addshadow(cornerRadius : CGFloat, shadowOpacity : Float ,shadowColor : CGColor ,shadowOffset : CGSize ,shadowRadius : CGFloat ){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.clipsToBounds = false
    }
    
    
}

struct ProfileData {
    var index : String
    var name: String
    var description: String
    var userUid : String
    var image : String
}
