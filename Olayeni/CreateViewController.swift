//
//  CreateViewController.swift
//  Olayeni
//
//  Created by Fianko Buckle on 12/4/19.
//  Copyright © 2019 Fianko Buckle. All rights reserved.
//

import UIKit
import Parse

class CreateViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var retypePasswordField: UITextField!
    let genders: [String] = ["Male","Female"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onCreateAcct(_ sender: Any) {
        if passwordField.text == retypePasswordField.text{
            var user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            // other fields can be set just like with PFObject
            user["weight"] = weightField.text
            user["gender"] = genderSegment.selectedSegmentIndex
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "backToLoginSegue", sender: nil)
                }else{
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }else{
            let alertController = UIAlertController(title: "Passwords Don't Match", message:
                "Make sure the passwords match", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
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
