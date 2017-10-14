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
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var btnCal: UIButton!
    @IBOutlet weak var ycontTotalFee: NSLayoutConstraint!
    @IBOutlet weak var lblComputer: UILabel!
    @IBOutlet weak var lblPasting: UILabel!
    @IBOutlet weak var lblMuta: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblStampDuty: UILabel!
    @IBOutlet weak var lblReg: UILabel!
    var deedObject:PFObject?
    var stampDuty = NSNumber(floatLiteral: 0.0)
    var reg = NSNumber(floatLiteral: 0.0)
    var total:Float?
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let code = deedObject?.object(forKey: "deedcode") as? String
        self.title = deedObject?.object(forKey: "deedname") as? String
        if((self.total) != nil){
            ycontTotalFee.constant = 28
            calc()
        }
        else if(code == "2" || code == "12"  || code == "14"){
            stampDuty  = (deedObject?.object(forKey: "FixedStampDuty") as? NSNumber)!
            
            reg  = (deedObject?.object(forKey: "registrationFee") as? NSNumber)!

        }else{
            ycontTotalFee.constant = 28
            txtValue.isHidden = true
            btnCal.isHidden = true

            stampDuty  = (deedObject?.object(forKey: "FixedStampDuty") as? NSNumber)!
        
            reg  = (deedObject?.object(forKey: "registrationFee") as? NSNumber)!
            showValues()
        }
        // Do any additional setup after loading the view.
    }
    func showValues(){
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency

        lblStampDuty.text = formatter.string(from: stampDuty)
        if(reg.intValue > 200000){
            reg = NSNumber.init(value: 200000)
        }
      //  let reg  = deedObject?.object(forKey: "registrationFee") as? NSNumber
        lblReg.text = formatter.string(from: reg)
        
        let mutation  = deedObject?.object(forKey: "mutationFee") as? NSNumber
        lblMuta.text =  formatter.string(from: mutation!)
        
        let paste  = deedObject?.object(forKey: "pastingFee") as? NSNumber
        lblPasting.text = formatter.string(from: paste!)
        
        let comp  = deedObject?.object(forKey: "computerzationFee") as? NSNumber
        lblComputer.text = formatter.string(from: comp!)
        let total = ((stampDuty.floatValue) + (reg.floatValue) + (mutation?.floatValue)! + (paste?.floatValue)! + (comp?.floatValue)!)
        lblTotal.text = formatter.string(from: NSNumber.init(value: total))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func calc()
    {
       
        let totalValue = self.total
            if(reg.intValue == 0){
                let regper  =  (deedObject?.object(forKey: "registartionFeePer") as? NSNumber)!
                reg  = NSNumber.init(value: ( totalValue! * (regper.floatValue * 0.01)))
            }
            if(stampDuty.intValue == 0){
                
                let stampPer  =  (deedObject?.object(forKey: "stampDutyPer") as? NSNumber)!
                stampDuty  = NSNumber.init(value: (totalValue! * (stampPer.floatValue * 0.01)))
            }
            showValues()
        
    }
    @IBAction func actoinCalculate(_ sender: AnyObject){
        if(txtValue.text?.isEmpty)!{
            
        }else{
            let totalValue = txtValue.text?.floatValue ?? 0
            if(reg.intValue == 0){
            let regper  =  (deedObject?.object(forKey: "registartionFeePer") as? NSNumber)!
            reg  = NSNumber.init(value: ( totalValue * (regper.floatValue * 0.01)))
            }
            if(stampDuty.intValue == 0){

            let stampPer  =  (deedObject?.object(forKey: "stampDutyPer") as? NSNumber)!
            stampDuty  = NSNumber.init(value: (totalValue * (stampPer.floatValue * 0.01)))
            }
            showValues()

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

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
