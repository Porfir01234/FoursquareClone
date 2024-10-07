//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Porfirio on 03/10/24.
//

import UIKit
import MapKit
import Parse
class DetailsVC: UIViewController {
  
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsNameLabel: UILabel!
    
    var chosenPlaceId = ""
    var chosenPlaceName = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromParse()
    }

    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenPlaceObject = objects![0]
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.detailsNameLabel.text = placeName
                        }
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.detailsTypeLabel.text = placeType
                        }
                        if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.detailsAtmosphereLabel.text = placeAtmosphere
                        }
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude){
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { data, error in
                                if error == nil {
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
 

}
