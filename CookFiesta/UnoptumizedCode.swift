////
////  CatagoryUploadVC.swift
////  CookFiesta
////
////  Created by Shreyank Vyas on 23/03/23.
////
//
//import UIKit
//import FirebaseDatabase
//import FirebaseStorage
//
//class CatagoryUploadVC: UIViewController {
//
//    var imgUrl : String!
//    var ref = Database.database().reference()
//    @IBOutlet weak var imgUpload: UIImageView!
//    @IBOutlet weak var foodName: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imgUpload.image = UIImage(named: "logo")
//        
//    }
//    
//    @IBAction func addImage(_ sender: UIButton) {
//        let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .photoLibrary
//            present(imagePicker, animated: true, completion: nil)
//    }
//    
//    @IBAction func Upload(_ sender: UIButton) {
//        if foodName.text != nil {
//            addChild()
//        }
//        else {
//            let alert = UIAlertController(title: "Alert", message: "All fields are mandatory", preferredStyle: .alert)
//            present(alert, animated: true)
//        }
//    }
//    
//    func addChild(){
//        ref.child("Category").child(foodName.text!).setValue(["Name":foodName.text!,"Image": imgUrl]) { error, ref in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            else
//            {
//                let alert = UIAlertController(title: "uploded", message: "data uploded Successfully", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default))
//                self.present(alert, animated: true)
//            }
//        }
//    }
//    
//    
//    func UplodedimgUrl(image : UIImage) {
//            // Get a reference to the Firebase Storage instance
//            let storage = Storage.storage()
//
//            // Get a reference to the image file
//            let image = image
//            let imageData = image.jpegData(compressionQuality: 0.5)
//            let storageRef = storage.reference().child("Catagory/\(foodName.text!).jpg")
//
//            // Upload the image to Firebase Storage
//            let uploadTask = storageRef.putData(imageData!, metadata: nil) { metadata, error in
//                                
//                // Get the download URL of the uploaded file
//                storageRef.downloadURL { url, error in
//                    guard let downloadURL = url else {
//                        // Handle error
//                        return
//                    }
//                    
//                    // Use the download URL as needed
//                    print("Download URL: \(downloadURL)")
//                    self.imgUrl = "\(downloadURL)"
//                }
//            }
//           
//        
//    }
//    
//}
//
//// image picker
//
//extension CatagoryUploadVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    
//    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            // Set the image to your UIImageView
//            imgUpload.image = image
//            UplodedimgUrl(image: imgUpload.image!)
//        }
//        
//        dismiss(animated: true, completion: nil)
//        toast(message: "image Uploded Successfully")
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    
//    
//    
//    
//    func toast(message : String)
//    {
//        let toastlable = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 150, width: 200, height: 35))
//        toastlable.backgroundColor = .black.withAlphaComponent(0.6)
//        toastlable.textColor = .white
//        toastlable.textAlignment = .center
//        toastlable.text = message
//        toastlable.alpha = 1.0
//        toastlable.backgroundColor = .systemPink
//        toastlable.layer.cornerRadius = 10
//        toastlable.clipsToBounds = true
//        self.view.addSubview(toastlable)
//        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn) {
//            toastlable.alpha = 0.0
//        } completion: { (iscompleted) in
//            toastlable.removeFromSuperview()
//        }
//    }
//}
