//
//  ElectricityViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 7/16/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import MBProgressHUD
import Parse
class ElectricityViewController: UIViewController, PickerViewProtocol {
    var arrVillage:[PFObject]?
    var arrDept:[PFObject]?
    var selection:PFObject?
    @IBOutlet weak var view1: UIView!

    @IBOutlet weak var btnlandline: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.layer.borderColor = UIColor.colorFromCode(0x02CBFF).cgColor
        view1.layer.borderWidth = 2.0
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0x02CBFF)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0x02CBFF)
        self.getVillage()
        // Do any additional setup after loading the view.
    }
    @IBAction func action(_ sender: Any) {
        let btn = sender as? UIButton
        if(btn?.tag == 0){
            AppDelegate.getDelegateRef().call(btn: btn!)
        }
        else{
            AppDelegate.getDelegateRef().email(btn: btn!)

        }
    
    }

    @IBAction func direction(_ sender: Any) {
        performSegue(withIdentifier: "DirectionVC", sender: sender)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let directionVC = segue.destination as? DirectionViewController
        directionVC?.destination = CLLocation(latitude: Double((selection?.object(forKey: "lattitude") as? String)!)!, longitude: Double((selection?.object(forKey: "longitude") as? String)!)!)
        directionVC?.navigationColor = UIColor.colorFromCode(0x02CBFF)
        
    }

    @IBAction func actionArea(_ sender: Any) {
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "LOCATION"
        pickerVw.arrayObj = arrVillage!
        self.view.addSubview(pickerVw)

    }
    func rowSelected(index: Int) {
        self.setDatabyid(id: (self.arrVillage![index].object(forKey: "id") as? String)!)

    }
    func getVillage() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let villageQuery = PFQuery(className: "ElectricityVillage")
        villageQuery.limit = 1000
        villageQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
           if(error == nil){
                self.arrVillage = objects
                self.getDeptData()
           }else{
            let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
            alert.show()

            
            }
            }
        
    }
    func getDeptData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let query = PFQuery(className: "Electricity")
        query.limit = 1000
        query.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.arrDept = objects
                self.setDatabyid(id: (self.arrVillage![0].object(forKey: "id") as? String)!)
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    func setDatabyid(id:String){
        for object in arrDept!{
            if(object.object(forKey: "id") as? String == id){
                selection = object
                lblName.text = object.object(forKey: "name") as? String
                btnMobile.setTitle(object.object(forKey: "mobile") as? String, for: .normal)
                btnlandline.setTitle(object.object(forKey: "landline") as? String, for: .normal)
                btnEmail.setTitle(object.object(forKey: "email_id") as? String, for: .normal)

            }
        }
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
