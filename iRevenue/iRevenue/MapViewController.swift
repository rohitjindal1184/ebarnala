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
import MBProgressHUD
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var mapview:MKMapView?
    @IBOutlet var tableView:UITableView?

    let locationManager = CLLocationManager()
    var isAnnotationshowed = false
    var hospitals = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
       // getlocation()
        getHospital()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0x82C5E5)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0x82C5E5)

        // Do any additional setup after loading the view.
    }
    func getHospital() {
        MBProgressHUD.showAdded(to: self.view, animated: true)

        let hospitalQuery = PFQuery(className: "HospitalName")
        hospitalQuery.addDescendingOrder("id")
        hospitalQuery.limit = 1000
        hospitalQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.hospitals = objects!
                self.tableView?.reloadData()
       }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let annView:MKAnnotationView = (sender as? MKAnnotationView)!
//        let directionVC = segue.destination as? DirectionViewController
//        directionVC?.currentlocation = self.mapview?.userLocation.location
//        directionVC?.destination = CLLocation(latitude: (annView.annotation?.coordinate.latitude)!, longitude: (annView.annotation?.coordinate.longitude)!)
//        
//    }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HealthTableCell
        let hospital = hospitals[indexPath.row].object(forKey: "name") as? String
        cell?.lblTitle.text = hospital
        if(hospital?.hasPrefix("CHC"))!{
            cell?.imgIcon.image = #imageLiteral(resourceName: "chc")
        }else if(hospital?.hasPrefix("PHC"))!{
            cell?.imgIcon.image = #imageLiteral(resourceName: "phc")
        }else{
        }


        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = self.hospitals[indexPath.row]
        self.performSegue(withIdentifier: "detail", sender: selected)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? HospitalStaffViewController
        vc?.hospital = sender as? PFObject
    }
    

}

class HealthTableCell:UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

}
