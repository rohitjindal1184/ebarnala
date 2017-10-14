//
//  StampValueViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 10/10/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
class StampValueViewController: UIViewController, PickerViewProtocol {
    var deedObject:PFObject?
    var arrSRO:[PFObject]?
    var arrVillage:[PFObject]?
    var filterArrVillage:[PFObject]?
    var selectedrate:PFObject?
    @IBOutlet weak var swicth: UISwitch!
    @IBOutlet weak var txtFloor: UITextField!
    @IBOutlet weak var btnLand: DropDownButton!
    @IBOutlet weak var btnArea: DropDownButton!
    @IBOutlet weak var btnVillage: DropDownButton!
    @IBOutlet weak var lblValue: UILabel!
    var total:Float?
    var arrArea:[PFObject]?
    var filterArea:[PFObject]?
    
    @IBOutlet weak var txtArea: UITextField!
    @IBAction func swictValueChanged(_ sender: Any) {
        if swicth.isOn{
            txtFloor.isHidden = false
            
        }else{
            txtFloor.isHidden = true

        }
    }
    
    //StampLandtype
    @IBOutlet weak var btnSro: DropDownButton!
    var arrValue:[PFObject]?
    var filterValue:[PFObject]?
    var piker = 0
    var selectedSRO:PFObject?
    var selectedVillage:PFObject?
    var selectedArea:PFObject?
    var selectedLand = -1
    var areatype:[PFObject]?

    
    @IBAction func actionArea(_ sender: Any) {
        guard let _ = self.selectedSRO , let _ = self.selectedVillage else{
            let alert = UIAlertView(title: "Error", message: "Please Select SRO and Village.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "landname"
        pickerVw.arrayObj = filterArea!
        self.piker = 2
        self.view.addSubview(pickerVw)
    }
    @IBAction func actionVillage(_ sender: Any) {
        guard let _ = self.selectedSRO else{
            let alert = UIAlertView(title: "Error", message: "Please Select SRO.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "vname"
        pickerVw.arrayObj = filterArrVillage!
        self.piker = 1
        self.view.addSubview(pickerVw)
    }
    @IBAction func actionlandtype(_ sender: Any) {
        
        guard let _ = self.selectedSRO , let _ = self.selectedVillage else{
            let alert = UIAlertView(title: "Error", message: "Please Select SRO and Village.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return
        }

        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "LandTypeName"
        pickerVw.arrayObj = areatype!
        self.piker = 3
        self.view.addSubview(pickerVw)
    }
    func rowSelected(index:Int){
        if(self.piker == 0){
            self.selectedSRO = arrSRO?[index]
            btnSro.setTitle(self.selectedSRO?.object(forKey: "sroname") as? String, for: .normal)
            
            btnVillage.setTitle("Select Village", for: .normal)
            btnArea.setTitle("Select Area", for: .normal)
            btnLand.setTitle("Select Land Type", for: .normal)

             self.selectedVillage = nil
            self.selectedArea = nil
            self.selectedLand = -1
            self.filterVilaage(index: index)
self.selectedrate = nil

        } else if(self.piker == 1){
            self.selectedVillage = filterArrVillage?[index]
            self.selectedArea = nil
            self.selectedLand = -1
            btnVillage.setTitle(self.selectedVillage?.object(forKey: "vname") as? String, for: .normal)

            btnArea.setTitle("Select Area", for: .normal)
            btnLand.setTitle("Select Land Type", for: .normal)
            self.filterArea(index: index)
            self.selectedrate = nil


        }else if(self.piker == 2){
            self.selectedArea = filterArea?[index]
            self.selectedLand = -1
            btnArea.setTitle(self.selectedArea?.object(forKey: "landname") as? String, for: .normal)
            filterValueArr()


        }else{
            self.selectedrate = nil

            self.selectedLand = index + 1
            btnArea.setTitle("Select Area", for: .normal)
            btnLand.setTitle(areatype![index].object(forKey: "LandTypeName") as? String, for: .normal)
            self.filterAreawithland()
        }
        
    }
    func filterVilaage(index:Int){
        filterArrVillage?.removeAll()
        filterValue?.removeAll()
        let srocode = self.selectedSRO?.object(forKey: "srocode") as? String
        for value in arrValue!{
            let sro = value.object(forKey: "srocode") as? String
            if(sro == srocode){
                filterValue?.append(value)
                let vcode = value.object(forKey: "vcode") as? String
                for village in arrVillage!{
                    let villageCode = village.object(forKey: "vcode") as? String
                    
                    if(villageCode == vcode){
                        filterArrVillage?.append(village)
                    }
                }
            }

        }
       
    }
    
    
    func filterArea(index:Int){
        filterValue?.removeAll()
        filterArea?.removeAll()
        let srocode = self.selectedSRO?.object(forKey: "srocode") as? String
        let vcode = self.selectedVillage?.object(forKey: "vcode") as? String
        for value in arrValue!{
            let sro = value.object(forKey: "srocode") as? String
            let code = value.object(forKey: "vcode") as? String
            if(sro == srocode && vcode == code){
                filterValue?.append(value)
                let codearea = value.object(forKey: "areacode") as? String
    
                for area in arrArea!{
                    let areacode = area.object(forKey: "areacode") as? String
                    
                    if(areacode == codearea){
                        filterArea?.append(area)
                    }
                }
            }
            
        }
        
    }
    func filterAreawithland(){
        filterValue?.removeAll()
        filterArea?.removeAll()
        let srocode = self.selectedSRO?.object(forKey: "srocode") as? String
        let vcode = self.selectedVillage?.object(forKey: "vcode") as? String
        for value in arrValue!{
            let sro = value.object(forKey: "srocode") as? String
            let code = value.object(forKey: "vcode") as? String
            let landtype = value.object(forKey: "landtype") as? String
            if(sro == srocode && vcode == code && self.selectedLand == Int(landtype!)!){
                filterValue?.append(value)
                let codearea = value.object(forKey: "areacode") as? String
                
                for area in arrArea!{
                    let areacode = area.object(forKey: "areacode") as? String
                    
                    if(areacode == codearea){
                        filterArea?.append(area)
                    }
                }
            }
            
        }
        
    }
    func filterValueArr(){
        filterValue?.removeAll()
        let srocode = self.selectedSRO?.object(forKey: "srocode") as? String
        let vcode = self.selectedVillage?.object(forKey: "vcode") as? String
        let arecode = self.selectedArea?.object(forKey: "areacode") as? String
        for value1 in arrValue!{
            let sro = value1.object(forKey: "srocode") as? String
            let code = value1.object(forKey: "vcode") as? String
            let cc = value1.object(forKey: "areacode") as? String
            if(sro == srocode && vcode == code && arecode == cc){
                self.selectedrate = value1
                let formatter = NumberFormatter()
                formatter.locale = Locale.current
                let rate = value1.object(forKey: "rate") as? String
                lblValue.text = "Land Value is ₹ " + rate! + " Per Square Yard"
                return
            }
            
        }
        
    }
    @IBAction func actionSRO(_ sender: Any) {
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "sroname"
        pickerVw.arrayObj = arrSRO!
        self.piker = 0
        self.view.addSubview(pickerVw)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = deedObject?.object(forKey: "deedname") as? String
        getArea()
        getValue()
        getLandtype()
        getVillage()
        getSRO()
        let button = UIButton(type: .custom)
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(calculateStampDuty), for: .touchUpInside)
        let barbutton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barbutton
        // Do any additional setup after loading the view.
    }
    func calculateStampDuty(){
        let area = txtArea.text?.floatValue ?? 0.0
        if(self.selectedrate == nil || area <= 0){
            let alert = UIAlertView(title: "Error", message: "Please select correct Area.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
return
        }
        if(swicth.isOn){
            let floor = Int(txtFloor.text!) ?? 0
            if(floor <= 0){
                let alert = UIAlertView(title: "Error", message: "Please Enter Constructed Floors.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                return

            }
        }
        let rate = self.selectedrate?.object(forKey: "rate") as? String
        total = (rate?.floatValue)! * area
        if(swicth.isOn){
            let floor = Int(txtFloor.text!) ?? 0
            var floorper = 0.0
            if(floor > 0){
                floorper = 0.05 * (Double(floor) + 1.0)
            }
            total = total! + (total! * Float(floorper))
            
        }
        self.performSegue(withIdentifier: "total", sender: total)
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as? StampTotalDutyViewController
        vc?.total = total
        vc?.deedObject = deedObject
    }
    func getSRO() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "SRO")
        tehsilQuery.addAscendingOrder("srocode")
        
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.arrSRO = objects!
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    
    func getVillage() {
        let tehsilQuery = PFQuery(className: "StampDutyVillage")
        tehsilQuery.limit = 2000

        tehsilQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
                self.arrVillage = objects!
                self.filterArrVillage = objects!

            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    func getLandtype() {
        let tehsilQuery = PFQuery(className: "StampLandtype")
        tehsilQuery.limit = 2000

        tehsilQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
                self.areatype = objects!
                
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    func getArea() {
        let tehsilQuery = PFQuery(className: "StampAreaCode")
        tehsilQuery.limit = 2000

        tehsilQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
                self.arrArea = objects!
                self.filterArea = objects!
                
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    
    func getValue() {
        let tehsilQuery = PFQuery(className: "StampDutyRate")
        tehsilQuery.limit = 2000

        tehsilQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
                self.arrValue = objects!
                self.filterValue = objects!
                
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
