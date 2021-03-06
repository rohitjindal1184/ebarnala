//
//  RTSViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 8/6/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import MBProgressHUD

class RTSViewController: UIViewController {
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "rts", ofType: "pdf")
        let targetURL = URL(fileURLWithPath: path!)
        let request = URLRequest(url: targetURL)
        webview.loadRequest(request)
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
