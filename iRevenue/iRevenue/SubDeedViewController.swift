//
//  SubDeedViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 9/10/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
class SubDeedViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    var deeds = [PFObject]()
    var deedCode = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select Sub Deed Type"
        getDEO()
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
    
    func getDEO() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "SubDeed")
        tehsilQuery.whereKey("deedcode", equalTo: deedCode)
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
