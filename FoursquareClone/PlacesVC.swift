//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Jazmin on 02/10/24.
//

import UIKit

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonCliked))
    }
    
    @objc func addButtonCliked () {
        
    }

    

}
