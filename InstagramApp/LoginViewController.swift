//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Dwayne Johnson on 3/17/17.
//  Copyright © 2017 GroupDiscountApp. All rights reserved.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let alert = UIAlertController(title: "Error", message: "Please enter a valid username and password" , preferredStyle: .alert)

        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            
            if user != nil {
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("User login failed.")
                print(error!.localizedDescription)
                let defaultAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        let alert = UIAlertController(title: "Error", message: "This Username already exists" , preferredStyle: .alert)

        newUser.username = usernameField.text ??  ""
        newUser.password = passwordField.text ?? ""
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Created a user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

            } else {
                print(error!.localizedDescription)
                let defaultAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            
            }
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
