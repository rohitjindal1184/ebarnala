//
//  PoliceViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 6/15/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import MBProgressHUD
import Parse
class PoliceViewController: UIViewController, PickerViewProtocol {
    var areas:[PFObject]?
    @IBOutlet var lblPSName:UILabel?
    @IBOutlet var lblIncharge:UILabel?
    @IBOutlet var lblMobile:UILabel?
    @IBOutlet var lblLandline:UILabel?
    @IBOutlet var lblEmailID:UILabel?
    @IBOutlet weak var lbldspmobile: UILabel!

    @IBOutlet weak var lblsspland: UILabel!
    @IBOutlet weak var lblsspname: UILabel!
    @IBOutlet weak var lblsspName: UILabel!
    @IBOutlet weak var lbldspLandline: UILabel!
    @IBOutlet weak var lbldspName: UILabel!
    @IBOutlet var scroll:UIScrollView?
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!

    var sspObject:PFObject?
    var dspObject:PFObject?
    var PoliceObject:PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getArea()
        getSSP()
        scroll?.contentSize = CGSize(width: 0, height: 1200)
        view1.layer.borderColor = UIColor.colorFromCode(0x6AB193).cgColor
        view2.layer.borderColor = UIColor.colorFromCode(0x6AB193).cgColor
        view3.layer.borderColor = UIColor.colorFromCode(0x6AB193).cgColor
        view1.layer.borderWidth = 2.0
        view2.layer.borderWidth = 2.0
        view3.layer.borderWidth = 2.0
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0x6AB193)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0x6AB193)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getArea() {
        let hospitalQuery = PFQuery(className: "VillagePolice")
        hospitalQuery.limit = 1000
        hospitalQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
            self.areas = objects
            self.getPSData(id: (objects?[0].object(forKey: "PS_id") as? NSNumber)!)
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }

    }
    func getPSData(id:NSNumber) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let psDataQuery = PFQuery(className: "PoliceStation")
        psDataQuery.whereKey("PS_id", equalTo: id)
        psDataQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
            if let object = objects?[0] {
                self.PoliceObject = object
                MBProgressHUD.hide(for: self.view, animated: true)
                self.lblPSName?.text = object.object(forKey: "PS_name") as? String
                self.lblIncharge?.text = object.object(forKey: "Incharge") as? String
                self.lblMobile?.text = object.object(forKey: "mobile") as? String
                self.lblLandline?.text = object.object(forKey: "phoneno") as? String
                self.lblEmailID?.text = object.object(forKey: "emailid") as? String
                self.getDSPData(id: (object.object(forKey: "DSP") as? String)!)
            }
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
    }
    func getDSPData(id:String){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let psDataQuery = PFQuery(className: "DSP")
        psDataQuery.getObjectInBackground(withId: id, block: { (object, error) in
                MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.dspObject = object
                self.lbldspName?.text = object?.object(forKey: "name") as? String
                self.lbldspmobile?.text = object?.object(forKey: "phoneno") as? String
                self.lbldspLandline?.text = object?.object(forKey: "mobile") as? String
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        })
    }
    func getSSP(){
        let psDataQuery = PFQuery(className: "DSP")
        psDataQuery.whereKey("isSSP", equalTo: true)
        psDataQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
            if let object = objects?[0] {
                self.sspObject = object
                self.lblsspName?.text = object.object(forKey: "name") as? String
                self.lblsspland?.text = object.object(forKey: "phoneno") as? String
                self.lblsspname?.text = object.object(forKey: "mobile") as? String
            }
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }

        }


    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func actionSelectArea(_ sender: Any) {
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "name"

        pickerVw.arrayObj = areas!
        self.view.addSubview(pickerVw)
    }
    @IBAction func actionGetDirection(_ sender: Any) {
        performSegue(withIdentifier: "DirectionVC", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let btn = sender as? UIButton
        var object:PFObject?
        if btn?.tag == 2{
            object = sspObject
        }else if btn?.tag == 1{
            object = dspObject
        }else {
            object = PoliceObject
        }
        let directionVC = segue.destination as? DirectionViewController
        directionVC?.destination = CLLocation(latitude: Double((object?.object(forKey: "latitude") as? String)!)!, longitude: Double((object?.object(forKey: "longtitude") as? String)!)!)
        directionVC?.navigationColor = UIColor.colorFromCode(0x6AB193)

    }
    func rowSelected(index: Int) {
        self.getPSData(id: (self.areas?[index].object(forKey: "PS_id") as? NSNumber)!)
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
