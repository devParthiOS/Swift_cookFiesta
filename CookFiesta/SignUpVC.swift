//
//  SignUpVC.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 20/03/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpVC: UIViewController {
    
    var ref = Database.database().reference().child("Users")
    
    @IBOutlet weak var nameField: CustomTxtField!
    
    @IBOutlet weak var emailField: CustomTxtField!
    
    @IBOutlet weak var passwordField: CustomTxtField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // signUp authentication
    
    @IBAction func signupAct(_ sender: UIButton) {
        
        guard let name = nameField.text , !name.isEmpty , let email = emailField.text , !email.isEmpty , let password = passwordField.text , !password.isEmpty
        else
        {
            let dialogMessage = UIAlertController(title: "Attention", message: "All fields are required", preferredStyle: .alert)
            // adding action Button
            let ok = UIAlertAction(title: "OK", style: .cancel)
            dialogMessage.addAction(ok)
            // Present alert to user
            self.present(dialogMessage, animated: true, completion: nil)
        return
        }
        // SignUp an redirect to Dashboard
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Failed to create user with email and password: \(error!.localizedDescription)")
                if error!.localizedDescription == "The email address is already in use by another account." {
                    let alert = UIAlertController(title: "Account alreadyExists", message: "Try to Login", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { _ in
                        self.navigationController?.popToRootViewController(animated: true)
                    }))
                    alert.addAction(UIAlertAction(title: "Cancle", style: .cancel,handler: { _ in
                        self.dismiss(animated: true)
                    }))
                    present(alert, animated: true)
                }
                else if error!.localizedDescription == "The email address is badly formatted."{
                    toast(message: "Incorrect Email formate")
                }
                return
            }
            // success
            ref.child(user.uid).setValue(["UserName" : nameField.text])
            let alert = UIAlertController(title: "SignUp Successfully", message: "Try to Login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { _ in
                self.performSegue(withIdentifier:"signupToLogin" , sender: self)
            }))
        }
       






    }
    
    
    
    
    
    
    
    
    ///
    
    
    @IBAction func alreadyActBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // Toast Func
    func toast(message : String)
    {
        let toastlable = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 150, width: 200, height: 35))
        toastlable.backgroundColor = .black.withAlphaComponent(0.6)
        toastlable.textColor = .white
        toastlable.textAlignment = .center
        toastlable.text = message
        toastlable.alpha = 1.0
        toastlable.backgroundColor = .systemPink
        toastlable.layer.cornerRadius = 10
        toastlable.clipsToBounds = true
        self.view.addSubview(toastlable)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseIn) {
            toastlable.alpha = 0.0
        } completion: { (iscompleted) in
            toastlable.removeFromSuperview()
        }
    }
    }

extension SignUpVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameField {
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
            
        }
        else if textField == emailField {
            return true
        }
        else if textField == passwordField {
            if range.location < 15 {
                return true
            }
        }
        return false
        
        
    }
    
    
    
    
}
