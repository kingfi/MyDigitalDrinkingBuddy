//
//  ProfileViewController.swift
//  Olayeni
//
//  Created by Fianko Buckle on 12/5/19.
//  Copyright © 2019 Fianko Buckle. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UITextField!
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var bacLabel: UILabel!
    let defaults = UserDefaults.standard

    //show profile informtion based on current user data collected in Userdefaults at login
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = defaults.string(forKey: "username")
        genderLabel.text = defaults.string(forKey: "gender")
        weightLabel.text = String(defaults.float(forKey: "weight"))
    
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
