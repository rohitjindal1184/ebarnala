//
//  RevenueViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 7/2/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
class RevenueViewController: UIViewController, PickerViewProtocol {

    @IBOutlet weak var lblpatwar: UILabel!
    @IBOutlet weak var lblKnagoo: UILabel!
    @IBOutlet weak var lblTehsil: UILabel!
    @IBOutlet weak var btnTehsil: UIButton!
    @IBOutlet weak var btnkanungo: UIButton!
    @IBOutlet weak var btnPatwar: UIButton!
    @IBOutlet weak var lblKangooName: UILabel!
    @IBOutlet weak var lblkangoomobile: UILabel!
    var arrTehsil:[PFObject]?
    var arrKangoo:[PFObject]?
    var selectedTehsil:PFObject?
    var selectedKangoo:PFObject?

    var kangooArrteh:[PFObject]?
    var picker:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getTehsil()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func rowSelected(index: Int) {
        if picker == 0 {
            selectedTehsil = arrTehsil?[index]
            self.lblTehsil.text = selectedTehsil?.object(forKey: "TEHSILNAME") as? String
            self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
        }
        else if picker == 1{
            selectedKangoo = kangooArrteh?[index]
            self.lblKnagoo.text = selectedTehsil?.object(forKey: "KANUNGOHALKA") as? String
            self.setKangooData(object: selectedKangoo!)
        }
    }
    @IBAction func actionTehsil(_ sender: Any) {
            let pickerVw = PickerView.instanceFromNib()
            pickerVw.frame = self.view.bounds
            pickerVw.delegate = self
            pickerVw.arrayObj = arrTehsil
            pickerVw.key = "TEHSILNAME"
            self.picker = 0
            self.view.addSubview(pickerVw)
            pickerVw.reloadObjects()
    }
    @IBAction func actionKanungo(_ sender: Any) {
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.arrayObj = kangooArrteh
        pickerVw.key = "KANUNGOHALKA"
        self.picker = 1
        self.view.addSubview(pickerVw)
        pickerVw.reloadObjects()
    }
    @IBAction func actionPatwar(_ sender: Any) {
    }
    func getTehsil() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "TehsilData")
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.getKangoo()
                self.arrTehsil = objects
                self.selectedTehsil = objects?[0]
                self.lblTehsil.text = objects?[0].object(forKey: "TEHSILNAME") as? String
            }
        }
        
    }
    func getKangoo() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "KangoData")
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.arrKangoo = objects
                self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
            }
        }
        
    }
    func getKangooWithTehID(id:String){
        var filterObjects = [PFObject]()
        for object in arrKangoo!{
            if(object.object(forKey: "TEHSIL_ID") as? String == id){
                filterObjects.append(object)
            }
        }
        kangooArrteh = filterObjects
        self.selectedKangoo = filterObjects[0]
        setKangooData(object: filterObjects[0])
    }
    func setKangooData(object:PFObject){
        self.lblKangooName.text = object.object(forKey: "kanungoName") as? String
        self.lblKnagoo.text = object.object(forKey: "KANUNGOHALKA") as? String
        self.lblkangoomobile.text = object.object(forKey: "Mobile") as? String

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
