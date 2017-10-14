//
//  StampDutyViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 9/10/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class StampDutyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var deeds = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select Deed Type"
        getDEO()
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0xED4738)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0xED4738)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return deeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndevtifier = "Cell"
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIndevtifier)
        let deed =  self.deeds[indexPath.row]
        cell.textLabel?.text = deed.object(forKey: "deedname") as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deed =  self.deeds[indexPath.row]
        let deedcode = deed.object(forKey: "deedcode") as? String
        let arrDeed = ["1", "3" , "11"]
        if(!arrDeed.contains(deedcode!)){
        performSegue(withIdentifier: "fixed", sender: deed)
        } else{
            performSegue(withIdentifier: "subdeed", sender: deed)

            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fixed"){
        let vc = segue.destination as? StampTotalDutyViewController
        vc?.deedObject = (sender as? PFObject)!
        }else{
            let vc = segue.destination as? StampValueViewController
            vc?.deedObject = (sender as? PFObject)!
        }
    }
    func getDEO() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "Deed")
        tehsilQuery.addAscendingOrder("deedcode")

        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.deeds = objects!
                self.tableView.reloadData()
                //  self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
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
