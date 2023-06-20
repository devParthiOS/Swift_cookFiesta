//
//  SearchVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 21/03/23.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class SearchVC: UIViewController {
    var indexpath : Int = 0
    let userUid = UserDefaults.standard.string(forKey: "User_Uid")
    var ref = Database.database().reference()
    var TvDataBucket : [FoodCategory] = []
    var filteredDataTV : [FoodCategory] = []
    var CvDataBucket : [FoodCategory] = []
    var icon : UIImageView!
    var space : UIView!
    @IBOutlet weak var popularCV: UICollectionView!
    @IBOutlet weak var searchBar: SearchBar!
    @IBOutlet weak var catagoryTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.IconLeft( imgName: "searchIcon")
        CvdataCall()
        TvdataCall()
        // for search Action
        searchBar.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDescription" {
            if let secVC = segue.destination as? DescriptionVC {
                let bucketData = filteredDataTV[indexpath]
                secVC.child = bucketData.namekey
                let imgUrl = URL(string: bucketData.image)
                secVC.imgUrl = imgUrl
            }
            
        }
    }
    
    // for search
    @objc func textFieldDidChange() {
        guard let searchText = searchBar.text else { return }
        // Filter your data source based on the search text
        let filteredData = TvDataBucket.filter { item in
            return item.name.lowercased().contains(searchText.lowercased()) || item.namekey.lowercased().contains(searchText.lowercased())
        }
        filteredDataTV = filteredData
        // Update the table view with the filtered data
        catagoryTB.reloadData()
    }
    
    func CvdataCall() {
        ref.child("Popular Of The Week").observe(.childAdded) { snapshot in
            let key = snapshot.key
            guard let value = snapshot.value as? [String : Any] else {return}
            if let name = value["Name"] as? String , let image = value["Image"] as? String {
                let food = FoodCategory(nameKey: key, name: name, image: image)
                self.CvDataBucket.append(food)
            }
            DispatchQueue.main.async {
                self.popularCV.reloadData()
            }
        }
        
    }
    
    func TvdataCall() {
        ref.child("Category").observe(.childAdded) { snapshot in
            let key = snapshot.key
            guard let value = snapshot.value as? [String : Any] else {return}
            if let name = value["Name"] as? String , let image = value["Image"] as? String {
                let food = FoodCategory(nameKey: key, name: name, image: image)
//                if name == "Burgers"{
                    self.TvDataBucket.append(food)
//                }
            }
            self.filteredDataTV = self.TvDataBucket
            DispatchQueue.main.async {
                self.catagoryTB.reloadData()
            }
        }
    }
    
    // search field left side icon setUp
    
    
    
    
    
    
}
// Collection View

extension SearchVC : UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CvDataBucket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularCV.dequeueReusableCell(withReuseIdentifier: "SearchCVC", for: indexPath) as! SearchCVC
        cell.layer.cornerRadius = 10
        cell.imgViewCatagory.layer.cornerRadius = 30
        cell.imgViewCatagory.sd_setImage(with: URL(string: CvDataBucket[indexPath.row].image))
        cell.dishLbl.text = CvDataBucket[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width
        return CGSize(width: size*0.6, height: 110)
    }
}


// Table View


extension SearchVC : UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" {
            return filteredDataTV.count
        } else {
            return TvDataBucket.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = catagoryTB.dequeueReusableCell(withIdentifier: "SearchTVC", for: indexPath) as! SearchTVC
        cell.selectionStyle = .none
        cell.cornerView.layer.cornerRadius = 10
        
        if searchBar.text != "" {
            let item = filteredDataTV[indexPath.row]
            cell.foodImg.sd_setImage(with:  URL(string: item.image), placeholderImage: UIImage(named: "logo"))
            cell.foodLbl.text = item.name
        }
        else {
            let item = TvDataBucket[indexPath.row]
            cell.foodImg.sd_setImage(with:  URL(string: item.image), placeholderImage: UIImage(named: "logo"))
            cell.foodLbl.text = item.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexpath = indexPath.row
        performSegue(withIdentifier: "SearchToDescription", sender: self)
    }
}

extension UITextField {
    
    func IconLeft(imgName : String){
        
        let icon = UIImageView()
        icon.image = UIImage(named: imgName)
        let contentView = UIView()
        contentView.addSubview(icon)
        contentView.frame = CGRectMake(0, 0, 30, 20)
        icon.frame = CGRectMake(10, 0, 20, 20)
        self.leftView = contentView
        self.leftViewMode = .always
    }
}
