//
//  DashboardButton.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/21/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class DashboardButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
    

}
