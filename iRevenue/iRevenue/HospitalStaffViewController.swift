//
//  HospitalStaffViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 7/27/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import MBProgressHUD
import Parse
class HospitalStaffViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var arrStaff = [PFObject]()
    var hospital:PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getStaffData()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0x82C5E5)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0x82C5E5)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getStaffData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let psDataQuery = PFQuery(className: "CivilSergeon")
        psDataQuery.whereKey("id", equalTo: (hospital?.object(forKey: "id") as? String)!)
        psDataQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)

            if(error == nil){
                    self.arrStaff = objects!
                self.tableView.reloadData()
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStaff.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? StaffCell
        cell?.vw.layer.borderColor = UIColor.colorFromCode(0x82C5E5).cgColor
        cell?.vw.layer.borderWidth = 2.0
        let obj = arrStaff[indexPath.row] 
        cell?.lblName.text = obj.object(forKey: "name") as? String
        cell?.lblDesignation.text = obj.object(forKey: "designation") as? String
        cell?.btnMobile.setTitle(obj.object(forKey: "mobile") as? String, for: .normal)
        cell?.btnEmail.setTitle(obj.object(forKey: "email") as? String, for: .normal)
        cell?.btnLandline.setTitle(obj.object(forKey: "landline") as? String, for: .normal)

        return cell!
    }
    
    @IBAction func actionGetDirection(_ sender: Any) {
        performSegue(withIdentifier: "DirectionVC", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let directionVC = segue.destination as? DirectionViewController
        directionVC?.destination = CLLocation(latitude: Double((hospital?.object(forKey: "latitude") as? String)!)!, longitude: Double((hospital?.object(forKey: "longtitude") as? String)!)!)
        directionVC?.navigationColor = UIColor.colorFromCode(0x82C5E5)
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

class StaffCell:UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnLandline: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var vw: UIView!

    @IBAction func action(_ sender: Any) {
        let btn = sender as? UIButton
        if(btn?.tag == 0){
            AppDelegate.getDelegateRef().call(btn: btn!)
        }
        else{
            AppDelegate.getDelegateRef().email(btn: btn!)
            
        }
        
    }


}
