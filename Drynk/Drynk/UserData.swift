//
//  UserData.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import Foundation

class UserData: NSObject{
    
    static let sharedInstance = UserData()
    
    let userDefaults = UserDefaults.standard
    
    func saveUserData(username: String, userCount: Int){
        let userData = [username: userCount]
        userDefaults.setValue(userData, forKey: DefaultKey.userData)
        userDefaults.setValue(true, forKey: DefaultKey.loginStatus)
    }
    
    func fetchUserData(completion:@escaping ([String:Int])->()){
        let data = userDefaults.value(forKey: DefaultKey.userData) as! [String:Int]
        completion(data)
    }
    
}

class Glasses: NSObject{
    static let sharedInstance = Glasses()
    
    let userDefaults = UserDefaults.standard
    
    func addGlass(glassNumber: Int){
        let timing = Date().timeIntervalSince1970
        if let glasses = userDefaults.value(forKey: DefaultKey.glasses) as? [Double: Int]{
           var total = glasses
            total.updateValue(glassNumber, forKey: timing)
            userDefaults.setValue(total, forKey: DefaultKey.glasses)
        }
        else{
            let total = [timing: glassNumber]
            userDefaults.setValue(total, forKey: DefaultKey.glasses)
        }
    }
    
    func setCount(count: Int){
            userDefaults.setValue(count, forKey: DefaultKey.dailyCount)
    }
    
    func getCount()->Int{
        if let value = userDefaults.value(forKey: DefaultKey.dailyCount) as? Int{
            return value
        }
        else{
            return 0
        }
    }
    
    
    
    /*private func getTimeString()->String{
        let date = Calendar.current.component(.day, from: Date())
        let day = Calendar.current.component(.weekday, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let year = Calendar.current.component(.year, from: Date())
        let hour = Calendar.current.component(.hour, from: Date())
        let min = Calendar.current.component(.minute, from: Date())
        let Timing = "\(day),"
    }*/
}
