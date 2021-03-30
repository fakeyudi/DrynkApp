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
    
    func save(_ history: [History]) {
        let data = history.map { try? JSONEncoder().encode($0) }
        userDefaults.set(data, forKey: DefaultKey.history)
    }
    
    func addGlass(glassNumber: Int){
        let currentDateString = getDateString()
        let splitDate = currentDateString.split(separator: ",")
        let currentDay = String(splitDate[0])
        let currentDate = String(splitDate[1])
        let entry = History(day: currentDay, date: currentDate, count: glassNumber)
        
        var history = getHistory()
        if history.count == 0{
            history = [entry]
            save(history)
        }
        else{
            for i in 0..<history.count{
                if history[i].date == currentDate{
                    history[i] = entry
                }
                else{
                    history.append(entry)
                }
            }
            save(history)
        }
    }
    
    func getHistory()->[History]{
        guard let encodedData = UserDefaults.standard.array(forKey: DefaultKey.history) as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(History.self, from: $0) }
    }
    
    func setCount(count: Int){
        userDefaults.setValue(count, forKey: DefaultKey.dailyCount)
    }
    
    func setTotalCount(totalCount: Int){
        userDefaults.setValue(totalCount, forKey: DefaultKey.totalCount)
    }
    func getTotalCount()->Int{
        if let value = userDefaults.value(forKey: DefaultKey.totalCount) as? Int{
            return value
        }
        else{
            return 0
        }
    }
    
    func getCount()->Int{
        if let value = userDefaults.value(forKey: DefaultKey.dailyCount) as? Int{
            return value
        }
        else{
            return 0
        }
    }
    
    
    
    private func getDateString()->String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE,dd MMMM yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        print("Current date is \(currentDateString)")
        return(currentDateString)
    }
}
