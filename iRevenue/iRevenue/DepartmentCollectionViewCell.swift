//
//  DepartmentCollectionViewCell.swift
//  iRevenue
//
//  Created by MobileProgramming on 7/18/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgIcon: UIImageView!
}

class DepartmentModal{
    var title = ""
    var icon:UIImage?
    var backGroundColor:UIColor?
    class func createArray()->[DepartmentModal]{
        let revnue = DepartmentModal()
        revnue.title = "Revenue"
        revnue.icon = #imageLiteral(resourceName: "rev")
        revnue.backGroundColor = UIColor.colorFromCode(0xED4738)
        
        let hospital = DepartmentModal()
        hospital.title = "Health"
        hospital.icon = #imageLiteral(resourceName: "hospital")
        hospital.backGroundColor = UIColor.colorFromCode(0x82C5E5)
        
        let police = DepartmentModal()
        police.title = "Police"
        police.icon = #imageLiteral(resourceName: "Police")
        police.backGroundColor = UIColor.colorFromCode(0x6AB193)
        
        
        let elect = DepartmentModal()
        elect.title = "Electricity"
        elect.icon = #imageLiteral(resourceName: "electricity")
        elect.backGroundColor = UIColor.colorFromCode(0x02CBFF)
        
        let education = DepartmentModal()
        education.title = "Education"
        education.icon = #imageLiteral(resourceName: "education")
        education.backGroundColor = UIColor.colorFromCode(0xED4738)
        
        let welfare = DepartmentModal()
        welfare.title = "Welfare"
        welfare.icon = #imageLiteral(resourceName: "welfare")
        welfare.backGroundColor = UIColor.colorFromCode(0x82C5E5)

        let suvida = DepartmentModal()
        suvida.title = "Suvida Kendra"
        suvida.icon = #imageLiteral(resourceName: "suvida")
        suvida.backGroundColor = UIColor.colorFromCode(0x6AB193)
        
        let food = DepartmentModal()
        food.title = "Food and Suply"
        food.icon = #imageLiteral(resourceName: "food")
        food.backGroundColor = UIColor.colorFromCode(0x02CBFF)

        
        return [revnue, hospital,police, elect, education, welfare, suvida, food]
    }
}

extension UIColor {
    public static func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
