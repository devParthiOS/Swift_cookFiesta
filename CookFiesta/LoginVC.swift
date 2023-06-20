//
//  ViewController.swift
//  CookFiesta
//
//  Created by Shreyank Vyas on 20/03/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn


class LoginVC: UIViewController  {
    
    @IBOutlet weak var emailField: CustomTxtField!
    var hideShowBtn : UIButton!
    var realTimeDB = FirebaseDatabase.Database.database().reference()
    let email = UserDefaults.standard.string(forKey: "User_Email")
    @IBOutlet weak var passwordField: CustomTxtField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtRight()
        
    }
//    MARK :- Google Login
    
    
    @IBAction func btnForgotPwd(_ sender: Any) {
        
        if emailField.text != ""{
            Auth.auth().sendPasswordReset(withEmail: emailField.text!) { error in
                if let error = error {
                    // Handle the error here
                    popUpAlert(title: "Opps!", message: "\(error.localizedDescription)", self: self)
                } else {
                    popUpAlert(title: "Reset Confirm", message: "Check Your MailBox", self: self)
                }
            }
        }
        else{
            popUpAlert(title: "Please", message: "Enter Your Email", self: self)
        }
    }
    
    
    
    
    @IBAction func btnGoogleLogin(_ sender: UIButton) {
    }
    
    
    
    
    
    
    // txtfield Secure entry Button
    
    func txtRight(){
        hideShowBtn = UIButton(type: .custom)
        hideShowBtn.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        hideShowBtn.frame = CGRect(x: CGFloat(passwordField.frame.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //        hideShowBtn.setImage(UIImage(named: "show"), for: .normal)
        //        hideShowBtn.backgroundColor = .blue
        hideShowBtn.setTitle("Show  ", for: .normal)
        passwordField.rightView = hideShowBtn
        passwordField.rightViewMode = .always
    }
    
    @objc func buttonTapped() {
        if passwordField.isSecureTextEntry == true
        {
            hideShowBtn.isSelected = true
            //            hideShowBtn.setImage(UIImage(named: "hide"), for: .selected)
            hideShowBtn.setTitle("Hide  ", for: .selected)
            passwordField.isSecureTextEntry = false
        }
        else if passwordField.isSecureTextEntry == false
        {
            hideShowBtn.isSelected = false
            //           hideShowBtn.setImage(UIImage(named: "show"), for: .normal)
            hideShowBtn.setTitle("Show  ", for: .normal)
            passwordField.isSecureTextEntry = true
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        // validating that no fields are empty
        if emailField.text == "" || passwordField.text == ""{
            
            // Create a new alert
            let dialogMessage = UIAlertController(title: "Attention", message: "All fields are required", preferredStyle: .alert)
            // adding action Button
            let ok = UIAlertAction(title: "OK", style: .cancel)
            dialogMessage.addAction(ok)
            // Present alert to user
            self.present(dialogMessage, animated: true, completion: nil)
            
        }
        else {
            
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [self] authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print("Failed to sign in with email and password: \(error!.localizedDescription)")
                    if error!.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        toast(message: "Such User Doesn't Exist")
                    }
                    else if error!.localizedDescription == "The password is invalid or the user does not have a password." {
                        toast(message: "invalid Password")
                    }
                    else if error!.localizedDescription == "The email address is badly formatted." {
                        toast(message: "Wrong Email or password")
                    }
                    return
                }
                UserDefaults.standard.set(user.uid, forKey: "User_Uid")
                UserDefaults.standard.set(user.email, forKey: "User_Email")
                UserDefaults.standard.set(true, forKey: "IsLoggedin")
                let st = UIStoryboard(name: "Main", bundle: nil)
                let nextVc = st.instantiateViewController(withIdentifier: "DashboardVC")
                let Nv = UINavigationController(rootViewController: nextVc)
                let sceneDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = Nv
                print("User \(user.email!) signed in successfully")
//              performSegue(withIdentifier: "loginToDashboard", sender: self)
            }
        }
        
        
    }
    
    // Toast
    func toast(message : String)
    {
        let toastlable = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 65, y: self.view.frame.size.height - 150, width: 200, height: 35))
        toastlable.center = self.view.center
        toastlable.frame.origin.y = self.view.frame.size.height - 150
        
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

extension LoginVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField {
            return true
            
        }
        else if textField == passwordField {
            if range.location < 15 {
                return true
            }
        }
        return false
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == passwordField
//        {
//            view.endEditing(true)
//        }
//        return false
//    }
}

