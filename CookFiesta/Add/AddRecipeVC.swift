//
//  AddRecipeVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 21/03/23.
//

import UIKit
import FirebaseDatabase



class AddRecipeVC: UIViewController {
    var databucket : [FoodCategory] = []
    
    
    var ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.child("category").observe(.childAdded) { snapshot in
            let key = snapshot.key
            guard let value = snapshot.value as? [String : Any] else {return}
            if let name = value["name"] as? String , let image = value["image"] as? String {
                let food = FoodCategory(nameKey: key, name: name, image: image)
                self.databucket.append(food)
                print(self.databucket.count)
                print(self.databucket)
              
            }
        }
            }
        
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



// model for category


