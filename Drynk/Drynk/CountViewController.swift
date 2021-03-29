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
        counter = 0
        setDesign()
        user.fetchUserData { [self] (user) in
            username = Array(user.keys)[0]
            count = Array(user.values)[0]
        }
        
        
        // Do any additional setup after loading the view.
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
        //glass.addGlass(glassNumber: counter)
        glass.setCount(count: counter)
        counterLabel.text = String(format: "%02d",glass.getCount())
        if counter == count{
            congoAlert(title: "WOHOO... YOU DID IT", message: "Congratulations... You Achieved your daily target!")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
