//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Porfirio on 02/10/24.
//

import UIKit
import Parse
class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonCliked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
    }
    
    @objc func addButtonCliked () {
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
    @objc func logoutButtonClicked () {
       
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    

}
