//
//  alcoholViewController.swift
//  Olayeni
//
//  Created by Fianko Buckle on 12/6/19.
//  Copyright © 2019 Fianko Buckle. All rights reserved.
//

import UIKit
import Parse

class alcoholViewController: UIViewController {

    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abvLabel: UILabel!
    
    @IBOutlet weak var servingEntry: UITextField!
    
    @IBOutlet weak var servingLabel: UILabel!
    
    var drink: Drink!
    
    let defaults = UserDefaults.standard
    
    //set labels
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandLabel.text = drink.brand!
        typeLabel.text = drink.type!
        abvLabel.text =  String(drink.aBV) + "%"

        // Do any additional setup after loading the view.
    }
    
    //Logs drinking events into drinking diary
    @IBAction func onLogIntoDiary(_ sender: Any) {
        //creates a date and formats it
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        print(date)
        
        //checks if serving has been filled and then logs diary entry with PFObject API
        if servingEntry.text == "" {
            let alert = UIAlertController(title: "No Input", message: "Must have input to add to diary.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }else{
            let diaryObj = PFObject(className:"DiaryEntries")
            diaryObj["userId"] = defaults.string(forKey: "objectId")
            diaryObj["date"] = formattedDate
            diaryObj["brand"] = drink.brand!
            diaryObj["type"] = drink.type!
            diaryObj["aBV"] = drink.aBV
            diaryObj["amt"] = servingEntry.text
            diaryObj.saveInBackground { (succeeded, error)  in
                if (succeeded) {
                    let alert = UIAlertController(title: "Success", message: "The entry was successfully logged  in", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Oops", message: "Something went wrong. Please try again later", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

                    self.present(alert, animated: true)                }
            }

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
