//
//  SetDetailsViewController.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import UIKit

class SetDetailsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    let user = UserData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        // Do any additional setup after loading the view.
    }
    
    func setDesign(){
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 15
        
        nameTextField.clipsToBounds = true
        nameTextField.layer.cornerRadius = 15
        
        countTextField.clipsToBounds = true
        countTextField.layer.cornerRadius = 15
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if nameTextField.text != nil && countTextField.text != nil{
            user.saveUserData(username: nameTextField.text!, userCount: Int(countTextField.text!)!)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "countVC")
            self.present(vc, animated: true)
            
        }
        else{
            Alert(title: "INVALID DATA", message: "Name or Count field might be empty!")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
 
}
