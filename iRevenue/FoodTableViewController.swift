//
//  FoodTableViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 8/1/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
class FoodTableViewController: UITableViewController, DetailCellProtocol,PickerViewProtocol {
    var objects = [PFObject]()
    var villages = [PFObject]()
    var selectedObjects = [PFObject]()
    var color = UIColor.colorFromCode(0x02CBFF)
    var titleLabel = "Food and Supply"
    var table = "Food"
    var className = "Food"
    var villageKey = "villages"
    var longtitude = "longtitude"
    var isLoaded = false
    var isBtnSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : color
        ]
        if(className == "Food"){
            titleLabel = "Food and Supply"
            color = UIColor.colorFromCode(0x02CBFF)
            table = "Food"
            villageKey = "villages"
            longtitude = "longtitude"
        }else if(className == "electricity") {
            titleLabel = "Electricity"
            color = UIColor.colorFromCode(0x02CBFF)
            table = "ElectricityNew"
            villageKey = "villages"
            longtitude = "longtitude"
        }else if(className == "health"){
            titleLabel = "Health"
            color = UIColor.colorFromCode(0x82C5E5)
            table = "Health"
            villageKey = "currentPosting"
            longtitude = "longtitude"
        }
        else{
            titleLabel = "Suvida Kendra"
            color = UIColor.colorFromCode(0x6AB193)
            table = "sevaKendra"
villageKey = "village"
            longtitude = "longitude"
        }
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : color
        ]

        self.navigationItem.title = titleLabel
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.tintColor = color
        self.getFood()
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
        return selectedObjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DetailTableViewCell
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        if(cell == nil) {
            cell = DetailTableViewCell.instanceFromNib()
        }
        cell?.object = selectedObjects[indexPath.row]
        cell?.delegate = self
        cell?.color = color
        cell?.loadData()
        
        // Configure the cell...
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
  
    func selectArea(){
        if(isLoaded){
        let pickerVw = PickerView.instanceFromNib()
        pickerVw.frame = self.view.bounds
        pickerVw.delegate = self
        pickerVw.key = "village"
        pickerVw.arrayObj = villages
        self.view.addSubview(pickerVw)
        }else{
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "Please Wait. We are loading data."
            isBtnSelected = true
        }
    }
    func rowSelected(index: Int) {
        self.showDataForVillage(village: villages[index])
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 20, width: 200, height: 40)
        btn.setTitle("Select Village", for: .normal)
        btn.backgroundColor = color
        btn.addTarget(self, action: #selector(FoodTableViewController.selectArea), for: .touchUpInside)
        btn.center = CGPoint(x: view.center.x, y: btn.center.y)
        btn.layer.cornerRadius = 20.0
        view.addSubview(btn)
        return view
    }
    func direction(object: PFObject) {
        performSegue(withIdentifier: "DirectionVC", sender: object)
        
    }
    func getFood() {
        let tehsilQuery = PFQuery(className: table)
        tehsilQuery.limit = 1000
        tehsilQuery.findObjectsInBackground { (objects, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(error == nil){
                self.objects = objects!
                self.createVillage()
                //  self.getKangooWithTehID(id: (self.selectedTehsil?.object(forKey: "TEHSIL_ID") as? String)!)
            }else{
                let alert = UIAlertView(title: "Error", message: error?.localizedDescription, delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                
            }
        }
        
    }
    func createVillage(){
        for obj in self.objects{
            let strVillage = obj.object(forKey: villageKey) as? String
            if(strVillage?.isEmpty)!{
                continue
            }
            let arrVillage = strVillage?.components(separatedBy: "/")
            for str in arrVillage!{
               let village = str.replacingOccurrences(of: "/", with: "")
                if(checkDuplicateVillage(village: village)){
                    continue
                }
                let villageObject = PFObject(className: "Food")
                villageObject.setObject(village, forKey: "village")
                villages.append(villageObject)
            }
        }
        isLoaded = true
        if(isBtnSelected){
        selectArea()
        }
    }
    func checkDuplicateVillage(village:String)->Bool{
        for villObj in self.villages{
            if(village == villObj.object(forKey: "village") as? String){
                return true
            }
        }
        
        return false
    }
    func showDataForVillage(village:PFObject){
        selectedObjects.removeAll()
        for obj in self.objects{
            let strVillage = obj.object(forKey: villageKey) as? String
            let vill = village.object(forKey: "village") as? String
            if (strVillage?.contains(vill!))!{
                selectedObjects.append(obj)
            }
        }
        self.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selection = sender as? PFObject
        let directionVC = segue.destination as? DirectionViewController
        directionVC?.destination = CLLocation(latitude: Double((selection?.object(forKey: "latitude") as? String)!)!, longitude: Double((selection?.object(forKey: longtitude) as? String)!)!)
        directionVC?.navigationColor = color
        
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
