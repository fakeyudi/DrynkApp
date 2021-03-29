//
//  AlertTrigger.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import Foundation
import UIKit

extension UIViewController
{
    //MARK: - ALERT function
    internal func Alert(title: String, message: String) {
        // Vibrates on errors
        //UIDevice.invalidVibrate() //TODO
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
    
    internal func congoAlert(title: String, message: String) {
        // Vibrates on errors
        //UIDevice.invalidVibrate() //TODO
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
}
