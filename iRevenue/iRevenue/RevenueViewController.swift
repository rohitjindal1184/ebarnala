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

    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblpatwar: UILabel!
    @IBOutlet weak var lblpatwariName: UILabel!
    @IBOutlet weak var lblTehsildarName: UILabel!
    @IBOutlet weak var btnPatwariMob: UIButton!
    @IBOutlet weak var btnTehsildarMob: UIButton!
    @IBOutlet weak var btnKangoMob: UIButton!
    
    @IBOutlet weak var lblKnagoo: UILabel!
    @IBOutlet weak var lblTehsil: UILabel!
    @IBOutlet weak var btnTehsil: UIButton!
    @IBOutlet weak var btnkanungo: UIButton!
    @IBOutlet weak var btnPatwar: UIButton!
    @IBOutlet weak var lblKangooName: UILabel!
    @IBOutlet weak var lblkangoomobile: UILabel!
    var arrTehsil:[PFObject]?
    var arrKangoo:[PFObject]?
    var arrPatwari:[PFObject]?
    var arrCombined = [PFObject]()
    var selectedTehsil:PFObject?
    var selectedKangoo:PFObject?

    var kangooArrteh:[PFObject]?
    var picker:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getTehsil()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0xED4738)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0xED4738)

        view1.layer.borderColor = UIColor.colorFromCode(0xED4738).cgColor
        view2.layer.borderColor = UIColor.colorFromCode(0xED4738).cgColor
        view3.layer.borderColor = UIColor.colorFromCode(0xED4738).cgColor
        view1.layer.borderWidth = 2.0
        view2.layer.borderWidth = 2.0
        view3.layer.borderWidth = 2.0
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0xED4738)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func rowSelected(index: Int) {
        self.showDataWithIndex(index: index)
//        if picker == 0 {
//            selectedTehsil = arrTehsil?[index]
//          //  self.lblTehsil.text = selectedTehsil?.object(forKey: "TEHSILNAME") as? String
//            //self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
//        }
//        else if picker == 1{
//            selectedKangoo = kangooArrteh?[index]
//            self.lblKnagoo.text = selectedTehsil?.object(forKey: "KANUNGOHALKA") as? String
//            self.setKangooData(object: selectedKangoo!)
//        }
    }
    @IBAction func actionTehsil(_ sender: Any) {
            let pickerVw = PickerView.instanceFromNib()
            pickerVw.frame = self.view.bounds
            pickerVw.delegate = self
            pickerVw.key = "searchText"
            pickerVw.arrayObj = arrCombined
            self.picker = 0
            self.view.addSubview(pickerVw)
    }
    @IBAction func actionKanungo(_ sender: Any) {
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "KANUNGOHALKA"

        pickerVw.arrayObj = kangooArrteh!
        self.picker = 1
        self.view.addSubview(pickerVw)
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
//                self.selectedTehsil = objects?[0]
//                self.lblTehsil.text = objects?[0].object(forKey: "TEHSILNAME") as? String
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    @IBAction func action(_ sender: Any) {
        let btn = sender as? UIButton
            AppDelegate.getDelegateRef().call(btn: btn!)
        
        
    }
    

    func getKangoo() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "KangoData")
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.arrKangoo = objects
                self.getPatwari()
              //  self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    func getPatwari(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "PatwarData")
        tehsilQuery.limit = 1000
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.arrPatwari = objects
                self.combineData()
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
    }
    func combineData(){
        for object in arrTehsil!{

            let arrKanunGo = self.getKangooWithTehID(id: (object.object(forKey: "TEHSIL_ID") as? String)!)
            for kanObj in arrKanunGo{

            let arrPat = self.getPatwariWithKangooID(id: (kanObj.object(forKey: "KANUNGO_ID") as? String)!)
                for patObj in arrPat{
                    let pfobject = PFObject(className: "ttt")
                    pfobject.setObject(object.object(forKey: "mobileNo")! , forKey: "tehMob")
                    pfobject.setObject(object.object(forKey: "TEHSILNAME")! , forKey: "TEHSILNAME")
                    pfobject.setObject(object.object(forKey: "thesildarName")!, forKey: "thesildarName")
                    let searchText = object.object(forKey: "TEHSILNAME") as? String

                    pfobject.setObject(kanObj.object(forKey: "KANUNGOHALKA")!, forKey: "KANUNGOHALKA")
                    pfobject.setObject(kanObj.object(forKey: "Mobile")!, forKey: "kanungoMobile")
                    pfobject.setObject(kanObj.object(forKey: "kanungoName")!, forKey: "kanungoName")
                    let searchText1 = searchText! + "| " + (kanObj.object(forKey: "KANUNGOHALKA") as? String)!

                    pfobject.setObject(patObj.object(forKey: "patwar_Circle_Name")!, forKey: "patwar_Circle_Name")
                    pfobject.setObject(patObj.object(forKey: "Patwari")!, forKey: "patwari")
                    pfobject.setObject(patObj.object(forKey: "village")!, forKey: "village")
                    pfobject.setObject(patObj.object(forKey: "fard_kendra")!, forKey: "fard_kendra")
                    pfobject.setObject(patObj.object(forKey: "mobile_No")!, forKey: "patwariMob")
                    let searchText2 = searchText1 + "| " + (patObj.object(forKey: "village") as? String)!
                    pfobject.setObject(searchText2 , forKey: "searchText")

                    arrCombined.append(pfobject)

                }
            }
        }
        self.showDataWithIndex(index: 0)
    }
    func showDataWithIndex(index:Int){
        let obj = arrCombined[index]
        lblpatwariName.text = obj.object(forKey: "patwari") as? String 
        btnPatwariMob.setTitle(obj.object(forKey: "patwariMob") as? String, for: .normal)
        lblKangooName.text = obj.object(forKey: "kanungoName") as? String
        lblTehsildarName.text = obj.object(forKey: "thesildarName") as? String
        
        btnTehsildarMob.setTitle(obj.object(forKey: "tehMob") as? String, for: .normal)
        btnKangoMob.setTitle(obj.object(forKey: "kanungoMobile") as? String, for: .normal)


    }
    func getKangooWithTehID(id:String)->[PFObject]{
        var filterObjects = [PFObject]()
        for object in arrKangoo!{
            if(object.object(forKey: "TEHSIL_ID") as? String == id){
                filterObjects.append(object)
            }
        }
        return filterObjects
//        self.selectedKangoo = filterObjects[0]
//        setKangooData(object: filterObjects[0])
    }
    
    func getPatwariWithKangooID(id:String)->[PFObject]{
        var filterObjects = [PFObject]()
        for object in arrPatwari!{
            if(object.object(forKey: "kanungo_id") as? String == id){
                filterObjects.append(object)
            }
        }
        return filterObjects
        //        self.selectedKangoo = filterObjects[0]
        //        setKangooData(object: filterObjects[0])
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
