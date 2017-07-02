//
//  KnowOptionViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/21/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class KnowOptionViewController: UIViewController {

    @IBOutlet var backButton:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func detailAction() {
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func revenueinfoAction(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let RevenueInfoDeptVC = storyboard.instantiateViewController(withIdentifier: "RevenueInfoDept")
        self.navigationController?.pushViewController(RevenueInfoDeptVC, animated: true)

    }
    @IBAction func callAction(){
        let url = NSURL(string: "tel://18001800168")
        if (UIApplication.shared.canOpenURL(url as! URL)) {
            UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
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
