//
//  CatagoryUploadVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 23/03/23.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class CatagoryUploadVC: UIViewController {
    
    var imgUrl : String!
    var ref = Database.database().reference()
    var uploadedImage : UIImage?
    @IBOutlet weak var imgUpload: UIImageView!
    @IBOutlet weak var foodName: UITextField!
    var myUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
   
    @IBAction func addImage(_ sender: UIButton) {
        setupImagepicker()
    }
    
    @IBAction func Upload(_ sender: UIButton) {
        
        if foodName.text != "" && uploadedImage != nil {
           
            addChild()
            
        }
        else{
            let alert = UIAlertController(title: "Make Sure", message: "All fields And Images are mandatory", preferredStyle: .alert)
            alert.addAction((UIAlertAction(title: "OK", style: .cancel)))
            present(alert, animated: true)
        }
        
    }
    
    func setupImagepicker (){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func UploadingImgForUrl(){
        guard let image = uploadedImage
        else
        {
            let alert = UIAlertController(title: "Add Image", message: "Upload Image First", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            return
            
        }
        
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
    
    func addChild(){
        
        guard let myImgUrl = myUrl else
        {
            return
        }
        
        
        guard let foodName = foodName.text else
        {
            return
        }
        
        ref.child("Category").child(foodName).setValue(["Name":foodName,"Image": myImgUrl]) { error, ref in
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

extension CatagoryUploadVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgUpload.image = image
            uploadedImage = image
            
        }
        picker.dismiss(animated: true, completion: nil)
        UploadingImgForUrl()
    }
}

