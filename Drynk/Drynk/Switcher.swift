//
//  Switcher.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: DefaultKey.loginStatus) as! Bool
        var rootVC : UIViewController?
       
            print(status)
        

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "countVC")
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "startVC")
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
       
        UIApplication.shared.windows.first?.rootViewController = rootVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
}
