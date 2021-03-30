//
//  CountViewController.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import UIKit

class CountViewController: UIViewController {

    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var dailyCountLabel: UILabel!
    @IBOutlet weak var addGlassButton: UIButton!
    
    
    let user = UserData.sharedInstance
    let glass = Glasses.sharedInstance
    
    var counter = Int(){
        didSet{
            counterLabel.text = String(format: "%02d",counter)
        }
    }
    
    var username = String(){
        didSet{
            self.navigationItem.title = "Hey, \(username)"
        }
    }
    var count = Int(){
        didSet{
            dailyCountLabel.text = "Daily Count: \(count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if shouldReset(){
            var totalCtr = glass.getTotalCount()
            totalCtr+=count
            glass.setTotalCount(totalCount: totalCtr)
            
            counter = 0
            glass.setCount(count: counter)
        }
        else{
            counter = glass.getCount()
        }
        setDesign()
        user.fetchUserData { [self] (user) in
            username = Array(user.keys)[0]
            count = Array(user.values)[0]
        }
    }
    func setDesign(){
        addGlassButton.clipsToBounds = true
        addGlassButton.layer.cornerRadius = 15
        
        counterView.clipsToBounds = true
        counterView.layer.cornerRadius = 130
        counterView.layer.borderWidth = 2
        counterView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func addGlassButton(_ sender: Any) {
        print(Date().timeIntervalSince1970)
        counter+=1
        glass.addGlass(glassNumber: counter)
        glass.setCount(count: counter)
        counterLabel.text = String(format: "%02d",glass.getCount())
        if counter == count{
            congoAlert(title: "WOHOO... YOU DID IT", message: "Congratulations... You Achieved your daily target!")
        }
    }
    
    @IBAction func setNotification(_ sender: Any) {
        notificationAlert()
    }
    
    func shouldReset()->Bool{
        let day = Calendar.current.component(.weekday, from: Date())
        if let prev = UserDefaults.standard.value(forKey: DefaultKey.lastTime) as? Int{
            if day != prev {
                UserDefaults.standard.setValue(day,forKey: DefaultKey.lastTime)
                return true
            }
            else{
                UserDefaults.standard.setValue(day,forKey: DefaultKey.lastTime)
                return false
            }
        }
        else{
            UserDefaults.standard.setValue(day,forKey: DefaultKey.lastTime)
            return true
        }
    }

}
