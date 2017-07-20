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
class ElectricityViewController: UIViewController {
    var arrVillage:[PFObject]?
    var arrDept:[PFObject]?
    var selection:PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionArea(_ sender: Any) {
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
                self.setDatabyid(id: (self.arrDept![0].object(forKey: "id") as? String)!)
            }
        }
        
    }
    func setDatabyid(id:String){
        for object in arrDept!{
            if(object.object(forKey: "id") as? String == id){
                selection = object
                
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
