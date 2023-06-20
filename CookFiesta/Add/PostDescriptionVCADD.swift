//
//  PostDescriptionVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 03/04/23.
//

import UIKit
import FirebaseDatabase


class PostDescriptionVCADD: UIViewController {
    @IBOutlet weak var txtChild: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtRecipe: UITextView!
    var ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func BtnSubmit(_ sender: UIBarButtonItem) {
        if txtChild.text == "" || txtType.text == "" {
            popUpAlert(title: "Make Sure", message: "All Fields Are Entered", self: self)
        }
        else{
            addChild()
        }
       
    }
    func addChild(){
        ref.child("Description").child(txtChild.text!).childByAutoId().setValue(["Recipe": txtRecipe.text!, "Type": txtType.text!]) { error, ref in
            if error != nil {
                print(error!.localizedDescription)
            }
            else
            {
                let alert = UIAlertController(title: "uploded", message: "data uploded Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }

}
