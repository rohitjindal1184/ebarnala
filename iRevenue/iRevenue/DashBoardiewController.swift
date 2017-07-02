//
//  ViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 5/20/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func optionSelection(_ sender:Any) {
        let button = sender as? UIButton

        if(button?.tag == 5) {
            self.performSegue(withIdentifier: "showDeptt", sender: sender)
        }
        
        self.performSegue(withIdentifier: "showTabbar", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let button = sender as? UIButton
        if(button?.tag != 5) {
        let vc = segue.destination as? TababarViewController
        vc?.selectedTab = button?.tag
        }

    }

}

