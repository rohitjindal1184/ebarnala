//
//  RevenueInfoViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/21/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class RevenueInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
    
    if cell == nil {
        cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
    }
    
    // we know that cell is not empty now so we use ! to force unwrapping but you could also define cell as
    // let cell = (tableView.dequeue... as? UITableViewCell) ?? UITableViewCell(style: ...)
    
        cell!.textLabel?.text = "Tehsil" +  String(indexPath.row) + " | " + "Circle" +  String(indexPath.row) + " | " + "Village" + String(indexPath.row);
        cell?.textLabel?.font = UIFont(name: "GillSans", size: 17.0);
        
    return cell!
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showOPtion", sender: nil)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }


}

