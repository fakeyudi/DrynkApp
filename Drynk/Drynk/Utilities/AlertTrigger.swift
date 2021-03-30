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
    
    internal func notificationAlert(){
        let alert = UIAlertController(title: "Set Reminder", message: "We'll Remind you in 1 hr to have a glass of Water", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Set Reminder", style: .default, handler: { action in
            LocalNotificationHandler.shared.setLocalNotification(title: "Time for a Drynk", subtitle: "Hey, It's time for your next glass of Water", timeInterval: 2)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert,animated: true,completion: nil)
    }
}
