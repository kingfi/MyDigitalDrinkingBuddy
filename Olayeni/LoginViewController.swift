//
//  LoginViewController.swift
//  Olayeni
//
//  Created by Fianko Buckle on 12/4/19.
//  Copyright © 2019 Fianko Buckle. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "objectId")
        defaults.removeObject(forKey: "gender")
        defaults.removeObject(forKey: "weight")
        defaults.synchronize()
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
                var currentUser = PFUser.current()
                print(currentUser)
                defaults.set(currentUser?.objectId as! String, forKey: "objectId")
                if currentUser != nil {
                    var query = PFUser.query()
                    query?.whereKey("objectId", equalTo: currentUser?.objectId as! String)
                    do{
                        var userObject = try query!.findObjects()
                        print(userObject)
                        print(userObject[0]["gender"]!)
                        defaults.set(username, forKey: "username")
                        var genderNum = userObject[0]["gender"] as! Int
                        var genderStr = ""
                        if genderNum  == 0{
                            genderStr = "Male"
                        }else{
                            genderStr = "Female"
                        }
                        print(genderStr)
                        defaults.set(genderStr, forKey: "gender")
                        var weight = Float(userObject[0]["weight"] as! String)
                        print(weight!)
                        defaults.set(weight!, forKey: "weight")

                    }catch{
                        print(error.localizedDescription)
                    }

                } else {
                  // Show the signup or login screen
                }
            }
            else{
                print("Error: \(error?.localizedDescription)")
                let alert = UIAlertController(title: "Login Unsuccessful", message: "Incorrect username/password", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }
        }
        
        
        

//        defaults.set(username, forKey: "username")
//        var genderNum = User?["gender"] as! Int
//        var genderStr = ""
//        if genderNum  == 0{
//            genderStr = "Male"
//        }else{
//            genderStr = "Female"
//        }
//        print(genderStr)
//        defaults.set(genderStr, forKey: "gender")
//        var weight = User?["weight"] as! Int
//        print(weight)
//        defaults.set(weight, forKey: "weight")
    }
    
    @IBAction func onSignUp(_ sender: Any) {
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
