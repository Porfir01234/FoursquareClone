//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Porfirio on 30/09/24.
//

import UIKit
import Parse
class ViewController: UIViewController {
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup
    }

    @IBAction func signInClicked(_ sender: UIButton) {
        
        if userNameText.text != nil && passwordText.text != nil {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Errir", messageInput: error?.localizedDescription ?? "Error!!")
                } else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        if userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password??")
        }
        
    }
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let addButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        
        alert.addAction(addButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

