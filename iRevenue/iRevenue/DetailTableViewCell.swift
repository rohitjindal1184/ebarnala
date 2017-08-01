//
//  DetailTableViewCell.swift
//  iRevenue
//
//  Created by MobileProgramming on 8/1/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit
import Parse
protocol DetailCellProtocol {
    func direction(object:PFObject)
}
class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnLandline: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var lblDesTitle: UILabel!
    @IBOutlet weak var lblmobiletitle: UILabel!
    @IBOutlet weak var lbllanlineTitle: UILabel!
    @IBOutlet weak var lblEmailTitle: UILabel!
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var btnDirection: UIButton!

    var delegate:DetailCellProtocol?
    var object:PFObject?
    var color:UIColor?
    @IBOutlet weak var vw: UIView!
    
    @IBAction func action(_ sender: Any) {
        let btn = sender as? UIButton
        if(btn?.tag == 0){
            AppDelegate.getDelegateRef().call(btn: btn!)
        }
        else{
            AppDelegate.getDelegateRef().email(btn: btn!)
            
        }
        
    }
    class func instanceFromNib() -> DetailTableViewCell {
        return UINib(nibName: "DetailTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailTableViewCell
    }

    func loadData(){
        vw.layer.borderColor = color?.cgColor
        vw.layer.borderWidth = 2.0

        lblName.text = object?.object(forKey: "name") as? String
        lblDesignation.text = object?.object(forKey: "designation") as? String
        lblAddress.text = object?.object(forKey: "address") as? String
        btnMobile.setTitle(object?.object(forKey: "mobile") as? String, for: .normal)
        btnEmail.setTitle(object?.object(forKey: "email") as? String, for: .normal)
        btnLandline.setTitle(object?.object(forKey: "landline") as? String, for: .normal)
        
        lblName.textColor = color
        lblDesignation.textColor = color
        lblAddress.textColor = color
        btnMobile.setTitleColor(color, for: .normal)
        btnEmail.setTitleColor(color, for: .normal)
        btnLandline.setTitleColor(color, for: .normal)
        
        lblNameTitle.textColor = color
        lblDesTitle.textColor = color
        lblmobiletitle.textColor = color
        lbllanlineTitle.textColor = color
        lblEmailTitle.textColor = color
        lblAddressTitle.textColor = color
        btnDirection.backgroundColor = color


    }
    
    @IBAction func actionDirectoin(_ sender: Any) {
        self.delegate?.direction(object: object!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
