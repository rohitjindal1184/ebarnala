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
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getArea()
        getSSP()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getArea() {
        let hospitalQuery = PFQuery(className: "VillagePolice")
        hospitalQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.areas = objects
            self.getPSData(id: (objects?[0].object(forKey: "PS_id") as? NSNumber)!)
        }

    }
    func getPSData(id:NSNumber) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let psDataQuery = PFQuery(className: "PoliceStation")
        psDataQuery.whereKey("PS_id", equalTo: id)
        psDataQuery.findObjectsInBackground { (objects, error) in
            if let object = objects?[0] {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.lblPSName?.text = object.object(forKey: "PS_name") as? String
                self.lblIncharge?.text = object.object(forKey: "Incharge") as? String
                self.lblMobile?.text = object.object(forKey: "mobile") as? String
                self.lblLandline?.text = object.object(forKey: "phoneno") as? String
                self.lblEmailID?.text = object.object(forKey: "emailid") as? String
                self.getDSPData(id: (object.object(forKey: "DSP") as? String)!)
            }
        }
    }
    func getDSPData(id:String){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let psDataQuery = PFQuery(className: "DSP")
        psDataQuery.getObjectInBackground(withId: id, block: { (object, error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.lbldspName?.text = object?.object(forKey: "name") as? String
                self.lbldspmobile?.text = object?.object(forKey: "phoneno") as? String
                self.lbldspLandline?.text = object?.object(forKey: "mobile") as? String
        })
    }
    func getSSP(){
        let psDataQuery = PFQuery(className: "DSP")
        psDataQuery.whereKey("isSSP", equalTo: true)
        psDataQuery.findObjectsInBackground { (objects, error) in
            if let object = objects?[0] {
                self.lblsspName?.text = object.object(forKey: "name") as? String
                self.lblsspland?.text = object.object(forKey: "phoneno") as? String
                self.lblsspname?.text = object.object(forKey: "mobile") as? String
            }

        }


    }
    @IBAction func actionSelectArea(_ sender: Any) {
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.arrayObj = areas
        pickerVw.key = "name"
        self.view.addSubview(pickerVw)
        pickerVw.reloadObjects()
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
