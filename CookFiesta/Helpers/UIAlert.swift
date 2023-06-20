//
//  UIAlert.swift
//  CookFiesta
//
//  Created by Vyas on 31/03/23.
//

import Foundation
import UIKit

func popUpAlert(title : String ,message : String ,self : UIViewController){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
    self.present(alert, animated: true)
    
}
