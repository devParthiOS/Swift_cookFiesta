//
//  DashboardVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 20/03/23.
//

import UIKit

class DashboardVC: UIViewController {
    var dashArrya : [DashData] = []
  
    @IBOutlet weak var dashboardItems: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
    
        dashArrya.append(DashData(iconImg: UIImage(named: "magnifying-glass"), contentName: "Search Recipe", navigationId: "SearchVC", navigationVc: SearchVC.self, backgroundImg: UIImage(named: "dashBG1")))
        dashArrya.append(DashData(iconImg: UIImage(named: "add"), contentName: "Add Recipe", navigationId: "AddRecipeVC", navigationVc: AddRecipeVC.self, backgroundImg: UIImage(named: "dashBG2")))
        dashArrya.append(DashData(iconImg: UIImage(named: "shopping-cart"), contentName: "Buy Recipe", navigationId: "BuyBookVC", navigationVc: BuyBookVC.self, backgroundImg: UIImage(named: "dashBG3")))
        dashArrya.append(DashData(iconImg: UIImage(named: "social-media"), contentName: "Posts ", navigationId: "PostVC", navigationVc: PostVC.self, backgroundImg: UIImage(named: "dashBG4")))
        dashArrya.append(DashData(iconImg: UIImage(named: "followers"), contentName: "Following ", navigationId: "FollowingVC", navigationVc: FollowingVC.self, backgroundImg: UIImage(named: "dashBG5")))
        dashArrya.append(DashData(iconImg: UIImage(named: "profile-user"), contentName: " Profile", navigationId: "ProfileVC", navigationVc: ProfileVC.self, backgroundImg: UIImage(named: "dashBG6")))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
    }
  
    
}
extension DashboardVC : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashArrya.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dashboardItems.dequeueReusableCell(withReuseIdentifier: "CustomDashboardCell", for: indexPath) as! CustomDashboardCell
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.backgroungImg.image = dashArrya[indexPath.row].backgroundImg
        cell.imageView.image = dashArrya[indexPath.row].iconImg
        cell.lblView.text = dashArrya[indexPath.row].contentName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = (collectionView.frame.size.width)
        return CGSize(width: size/2 - 30, height: size/2 - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let vcId = dashArrya[indexPath.row].navigationId
//        var vcClass = dashArrya[indexPath.row].navigationVc
        if indexPath.row == 4{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: vcId!)
            self.navigationController?.pushViewController(vc!, animated: true)
            vc!.navigationController?.isNavigationBarHidden = true
        }
        else{
            
            if indexPath.row == 5{
                let tb = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
              
                tb.selectedIndex = 4
                self.navigationController?.pushViewController(tb, animated: true)
        //        self.navigationController?.pushViewController(vc!, animated: true)
                tb.navigationController?.isNavigationBarHidden = true
            }
            else {
                let tb = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
              
                tb.selectedIndex = indexPath.row
                self.navigationController?.pushViewController(tb, animated: true)
        //        self.navigationController?.pushViewController(vc!, animated: true)
                tb.navigationController?.isNavigationBarHidden = true
            }
            
        }
       
        
    }
}







struct DashData{
    
    let backgroundImg : UIImage!
    let iconImg : UIImage!
    let contentName : String!
    let navigationId : String!
    let navigationVc : AnyClass!
    
    init(iconImg: UIImage!, contentName: String! ,navigationId : String!,navigationVc :AnyClass , backgroundImg: UIImage!) {
        self.iconImg = iconImg
        self.contentName = contentName
        self.navigationId = navigationId
        self.navigationVc = navigationVc
        self.backgroundImg = backgroundImg
    }
}
