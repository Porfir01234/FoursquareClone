//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Porfirio on 03/10/24.
//

import UIKit
import MapKit
import Parse
class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManeger = CLLocationManager()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer: )))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            // Crating pins
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManeger.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func saveButtonClicked() {
       //PARSE
        let placesModel = PlaceModel.sharedInstance
        let object = PFObject(className: "Places")
        object["name"] = placesModel.placeName
        object["type"] = placesModel.placeType
        object["atmosphere"] = placesModel.placeAtmosphere
        object["latitude"] = placesModel.placeLatitude
        object["longitude"] = placesModel.placeLongitude
        
        if let imageData = placesModel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        
        object.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "fromMapVCPlacesVc", sender: nil)
            }
        }
        
    }
    @objc func backButtonClicked() {
       
        self.dismiss(animated: true, completion: nil)
    }

}
