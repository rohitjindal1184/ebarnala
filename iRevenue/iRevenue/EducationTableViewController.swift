//
//  EducationTableViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 8/1/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
class EducationTableViewController: UITableViewController,DetailCellProtocol {
    var objects = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.colorFromCode(0xED4738)
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0xED4738)
        self.navigationController?.navigationBar.tintColor = UIColor.colorFromCode(0xED4738)
        self.getDEO()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DetailTableViewCell
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        if(cell == nil) {
            cell = DetailTableViewCell.instanceFromNib()
        }
        cell?.object = objects[indexPath.row]
        cell?.delegate = self
        cell?.color = UIColor.colorFromCode(0xED4738)
        cell?.loadData()

        // Configure the cell...

        return cell!
    }
    func direction(object: PFObject) {
        performSegue(withIdentifier: "DirectionVC", sender: object)

    }
    func getDEO() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let tehsilQuery = PFQuery(className: "DEO")
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.objects = objects!
                self.tableView.reloadData()
                //  self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selection = sender as? PFObject
        let directionVC = segue.destination as? DirectionViewController
        directionVC?.destination = CLLocation(latitude: Double((selection?.object(forKey: "latitude") as? String)!)!, longitude: Double((selection?.object(forKey: "longitude") as? String)!)!)
        directionVC?.navigationColor = UIColor.colorFromCode(0x02CBFF)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
