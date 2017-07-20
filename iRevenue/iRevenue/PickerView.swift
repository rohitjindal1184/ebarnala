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
class PickerView: UIView,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate  {
    var delegate:PickerViewProtocol?
    var arrData:[[String:Any]] = [[String:Any]]()
    var filterData:[[String:Any]] = [[String:Any]]()
    @IBOutlet var tableview:UITableView?
    var arrayObj:[PFObject]{
        get{
            return self.arrayObj
        }
        set(arr){
            for i in 0..<arr.count{
                let obj = arr[i].allKeys
                var object:[String:Any] = [String:Any]()
                for key in obj{
                    object[key] = arr[i].object(forKey: key)
                }
                object["index"] = i
                arrData.append(object)
            }
            filterData = arrData
            tableview?.reloadData()
        }
    }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let text = filterData[indexPath.row][key!]
        cell.textLabel?.text = filterData[indexPath.row][key!] as? String
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = filterData[indexPath.row]["index"] as? Int
        self.delegate?.rowSelected(index:index!)
        removeFromSuperview()

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            if textField.text?.lengthOfBytes(using: .utf8) == 1{
                filterData = arrData
                tableview?.reloadData()
            }
            else{
                let text = textField.text
                filterDataWithtext(string: text!)
                
            }
        }else {
            let text = textField.text! + string
            filterDataWithtext(string: text)

        }
        
        return true
    }
    func filterDataWithtext(string:String){
        filterData.removeAll()
        for object in arrData{
            var text = object[key!] as? String
            text = text?.lowercased()
            let txt = string.lowercased()
            if text?.range(of:txt) != nil{
                filterData.append(object)
            }
        }
        tableview?.reloadData()
    }
}
