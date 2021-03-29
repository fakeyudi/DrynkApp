//
//  ViewController.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        // Do any additional setup after loading the view.
    }
    
    func setDesign(){
        startBtn.clipsToBounds = true
        startBtn.layer.cornerRadius = 15
    }

    @IBAction func startBtn(_ sender: Any) {
        self.performSegue(withIdentifier: AppConstants.segues.startBtnSegue, sender: self)
    }
    
}

