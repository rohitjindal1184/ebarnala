//
//  ContactDetailViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/21/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        
        // we know that cell is not empty now so we use ! to force unwrapping but you could also define cell as
        // let cell = (tableView.dequeue... as? UITableViewCell) ?? UITableViewCell(style: ...)
        
        //cell!.textLabel?.text = "Tehsil" +  String(indexPath.row) + " | " + "Circle" +  String(indexPath.row) + " | " + "Village" + String(indexPath.row);
        cell?.textLabel?.font = UIFont(name: "GillSans", size: 17.0);
        
        return cell!
    }
    @IBAction func callActionContact(_ sender:Any){
        let btn:UIButton = sender as! UIButton
        let url = NSURL(string: "tel://" + btn.title(for: .normal)!)
        if (UIApplication.shared.canOpenURL(url! as URL)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }    
    }
    }
    
    @IBAction func mapAction(_ sender:Any) {
        self.performSegue(withIdentifier: "showDirection", sender: nil)
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
