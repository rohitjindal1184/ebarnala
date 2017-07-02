//
//  DirectionViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/21/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import CoreLocation
class DirectionViewController: UIViewController {
    @IBOutlet var webview: UIWebView?
    var currentlocation:CLLocation?
    var destination:CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        let current = String(format: "%f", (currentlocation?.coordinate.latitude)!) + "," + String(format: "%f", (currentlocation?.coordinate.longitude)!)
        let dest = String(format: "%f", (destination?.coordinate.latitude)!) + "," + String(format: "%f", (destination?.coordinate.longitude)!)

        let url = URL(string: "http://maps.google.com/?saddr=" + current + "&daddr=" + dest)
        webview?.loadRequest(URLRequest(url: url!))

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

}
