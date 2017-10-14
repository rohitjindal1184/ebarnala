//
//  DropDownButton.swift
//  iRevenue
//
//  Created by MobileProgramming on 10/12/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class DropDownButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.5
        let img = UIImageView(image: #imageLiteral(resourceName: "dropDown"))
        img.tintColor = UIColor.red
        img.frame = CGRect(x: self.bounds.size.width - 30, y: 8, width: 20, height: 16)
        self.addSubview(img)
        
    }

}
