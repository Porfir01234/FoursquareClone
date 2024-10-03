//
//  AddPlaces.swift
//  FoursquareClone
//
//  Created by Porfirio on 02/10/24.
//

import UIKit

class AddPlaceVC: UIViewController {
    
    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphere: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    

}
