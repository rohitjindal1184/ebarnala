//
//  StampTotalDutyViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 10/9/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
class StampTotalDutyViewController: UIViewController {
    @IBOutlet weak var lblComputer: UILabel!
    @IBOutlet weak var lblPasting: UILabel!
    @IBOutlet weak var lblMuta: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblStampDuty: UILabel!
    @IBOutlet weak var lblReg: UILabel!
    var deedObject:PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        let stampDuty  = deedObject?.object(forKey: "FixedStampDuty") as? NSNumber
        lblStampDuty.text =  stampDuty?.stringValue
        
        let reg  = deedObject?.object(forKey: "registrationFee") as? NSNumber
        lblReg.text =  reg?.stringValue

        let mutation  = deedObject?.object(forKey: "mutationFee") as? NSNumber
        lblMuta.text =  mutation?.stringValue

        let paste  = deedObject?.object(forKey: "pastingFee") as? NSNumber
        lblPasting.text =  paste?.stringValue

        let comp  = deedObject?.object(forKey: "computerzationFee") as? NSNumber
        lblComputer.text =  comp?.stringValue
        let total = ((stampDuty?.floatValue)! + (reg?.floatValue)! + (mutation?.floatValue)! + (paste?.floatValue)! + (comp?.floatValue)!)
        lblTotal.text = NSNumber.init(value: total).stringValue
        self.title = deedObject?.object(forKey: "deedname") as? String
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
