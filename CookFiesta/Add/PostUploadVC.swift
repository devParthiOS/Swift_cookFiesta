//
//  PostUploadVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 31/03/23.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class PostUploadVC: UIViewController {

    @IBOutlet weak var txtFood: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    var myUrl : String?
    var ref = Database.database().reference()
    let userUid = UserDefaults.standard.string(forKey: "User_Uid")
    override func viewDidLoad() {
        super.viewDidLoad()
        tapSetUp()
        
        
    }
    
    @IBAction func uploadPost(_ sender: UIButton) {
        if txtFood.text == "" || txtDescription.text == "" || myUrl == nil {
            popUpAlert(title: "Make Sure", message: "You added all data", self: self)
        }
        else{
            addChild()
        }
    }
    
    //    MARK :- TapGesture Setup
    
    func tapSetUp(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
    }

    //    MARK :- TapGesture Action
    
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    
//    MARK :- Add Data to Firebase
    
    func addChild(){
        ref.child("UsersPost").childByAutoId().setValue(["Description": txtDescription.text!, "Name": txtFood.text!, "Image": myUrl! , "userUid": userUid!]) { error, ref in
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


extension PostUploadVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = image
            uploadImageAndGetUrl(image: image) { result in
                switch result {
                case .success(let url):
                    // Handle the URL returned from Firebase Storage
                    self.myUrl = "\(url)"
                    print("Image uploaded successfully. URL: \(url)")
                case .failure(let error):
                    // Handle the error returned from Firebase Storage
                    print("Error uploading image: \(error.localizedDescription)")
                }
            }

        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}


