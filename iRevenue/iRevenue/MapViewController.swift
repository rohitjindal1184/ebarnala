//
//  MapViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 6/11/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet var mapview:MKMapView?
    let locationManager = CLLocationManager()
    var isAnnotationshowed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getlocation()
        getHospitals()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getHospitals() {
        let hospitalQuery = PFQuery(className: "Hospital")
        hospitalQuery.findObjectsInBackground { (objects, error) in
            self.addAnotations(objects: objects!)
        }
    }
    
    func addAnotations(objects:[PFObject]) {
        var annotatins:[MKAnnotation] = [MKAnnotation]()
        for  object  in objects {
            let annotation = MKPointAnnotation()
            let annotationLocation = CLLocationCoordinate2D(latitude: Double(object.object(forKey: "Location_Latitude" ) as! String)!, longitude: Double(object.object(forKey: "Location_longitude") as! String)!)
             annotation.coordinate = annotationLocation
            annotation.title = object.object(forKey: "Location_name") as? String
            let address = "address: " + (object.object(forKey: "Location_address") as? String)!
            let facilities = "\n\n Facilities: " + (object.object(forKey: "Location_Facilities") as? String)!
            var descp = address + facilities
            descp = descp.replacingOccurrences(of: ".", with: ",")
            annotation.subtitle = descp
            annotatins.append(annotation)
        }
        mapview?.showAnnotations(annotatins, animated: true)

    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        let reuseId = "space"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.image = #imageLiteral(resourceName: "pin")
            anView?.canShowCallout = true
            //THIS IS THE GOOD BIT
            let subtitleView = UILabel()
            subtitleView.font = subtitleView.font.withSize(12)
            subtitleView.numberOfLines = 0
            subtitleView.text = annotation.subtitle!
            anView?.detailCalloutAccessoryView = subtitleView
            
            let button = UIButton(type: .detailDisclosure)
            anView?.rightCalloutAccessoryView = button
            
            
            
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView?.annotation = annotation
        }
        return anView
    }
    func getlocation() {
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last! as CLLocation
        
        if(!isAnnotationshowed)
        {
            isAnnotationshowed = true
            //addannoation(location: newLocation)
            let center = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
            let region = MKCoordinateRegionMakeWithDistance(center, 3000, 3000)
            //MKCoordinateRegionMakeWithDistance(center, 1000, 1000)
            
            mapview?.setRegion(region, animated: true)

        }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "Direction", sender: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let annView:MKAnnotationView = (sender as? MKAnnotationView)!
        let directionVC = segue.destination as? DirectionViewController
        directionVC?.currentlocation = self.mapview?.userLocation.location
        directionVC?.destination = CLLocation(latitude: (annView.annotation?.coordinate.latitude)!, longitude: (annView.annotation?.coordinate.longitude)!)
        
    }
//    func addannoation(location: CLLocation) {
//        let annotation = MKPointAnnotation()
//        let annotationLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.003, longitude: location.coordinate.longitude + 0.003)
//        annotation.coordinate = annotationLocation
//        mapview?.showAnnotations([annotation], animated: true)
//        
//    }
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        
//        let center = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
//        let region = MKCoordinateRegionMakeWithDistance(center, 1000, 1000)
//        //   MKCoordinateRegionMakeWithDistance(center, 1000, 1000)
//        
//        mapview?.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
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
