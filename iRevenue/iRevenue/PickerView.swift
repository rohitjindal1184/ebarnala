//
//  PickerView.swift
//  iRevenue
//
//  Created by MobileProgramming on 6/15/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//
protocol PickerViewProtocol {
func rowSelected(index:Int)
}
import UIKit
import Parse
class PickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    var delegate:PickerViewProtocol?
    var arrayObj:[PFObject]?
    var key:String?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var picker: UIPickerView!
    @IBAction func actionDone(_ sender: Any) {
        self.delegate?.rowSelected(index: picker.selectedRow(inComponent: 0))
        removeFromSuperview()
    }
    class func instanceFromNib() -> PickerView {
        return UINib(nibName: "PickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PickerView
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func reloadObjects() {
        picker.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (arrayObj?.count)!
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        let object = arrayObj?[row]
        return object?.object(forKey: key!) as? String
    }
}
