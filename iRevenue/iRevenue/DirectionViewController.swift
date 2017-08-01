//
//  DirectionViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/21/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD
class DirectionViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet var webview: UIWebView?
    var currentlocation:CLLocation?
    var destination:CLLocation?
    var navigationColor:UIColor = UIColor.black
    override func viewDidLoad() {
        super.viewDidLoad()
        let dest = String(format: "%f", (destination?.coordinate.latitude)!) + "," + String(format: "%f", (destination?.coordinate.longitude)!)

        let url = URL(string: "http://maps.google.com/?saddr=" + "My%20Location" + "&daddr=" + dest)
        webview?.loadRequest(URLRequest(url: url!))
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : navigationColor
        ]
        self.navigationController?.navigationBar.tintColor = navigationColor
        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.view, animated: true)

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
