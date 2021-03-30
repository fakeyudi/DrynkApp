//
//  HistoryViewController.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 30/3/21.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var totalConsumedLabel: UILabel!
    @IBOutlet weak var totalGlassesLabel: UILabel!
    @IBOutlet weak var dailyCountLabel: UILabel!
    @IBOutlet weak var historyTV: UITableView!
    
    let glass = Glasses.sharedInstance
    let user = UserData.sharedInstance
    
    var count = Int()
    
    var history = [History](){
        didSet{
            historyTV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        history = glass.getHistory()
        historyTV.delegate = self
        historyTV.dataSource = self
        user.fetchUserData { [self] (user) in
            count = Array(user.values)[0]
        }
        if history.count != 0{
            totalConsumedLabel.text = String(getTotalConsumed(history: history))
            totalGlassesLabel.text = String(history.count*count)
        }
        totalGlassesLabel.text = String(count)
        dailyCountLabel.text = "Daily Count: \(count)"
    }
    
    func setDesign(){
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 25
    }
    
    func getTotalConsumed(history: [History])->Int{
        var total = 0
        for i in history{
            total+=i.count
        }
        return (total)
    }
   

}
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if history.count != 0{
            return history.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histCell", for: indexPath) as! HistoryTableViewCell
        cell.dayLabel.text = history[indexPath.row].day
        cell.dateLabel.text = history[indexPath.row].date
        cell.countLabel.text = String(format: "%02d", history[indexPath.row].count)
        return(cell)
    }
    
     func tableView(_ tableView: UITableView,
                            contextMenuConfigurationForRowAt indexPath: IndexPath,
                            point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: {
                suggestedActions in
            let shareAction =
                UIAction(title: "Share",
                         image: UIImage(systemName: "square.and.arrow.up")) { action in
                    self.performShare(indexPath: indexPath)
                }
                                            
         let cancelAction =
            UIAction(title: "Cancel", image: UIImage(systemName: "square.split.diagonal.2x2")) { action in }
            
           
            return UIMenu(title: "", children: [shareAction, cancelAction])
        })
    }
    
    func performShare(indexPath: IndexPath){
        let text = "Hey I drank \(history[indexPath.row].count) glasses of water on \(history[indexPath.row].day), \(history[indexPath.row].date) \n Checkout Drynk App to Track your Hydration habits!"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.topView
        
        // so that iPads won't crash
        if UIDevice.current.userInterfaceIdiom == .pad{
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        
        activityViewController.isModalInPresentation = true
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.saveToCameraRoll ]
        
        
        
        //completion handler
        activityViewController.completionWithItemsHandler = {activity, success, items, error in
            if !success{
                return
            }
            if activity == .postToFacebook{
                
            }
            if activity == .mail{
                
            }
            print(activity!)
            print("shared")
        }
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
