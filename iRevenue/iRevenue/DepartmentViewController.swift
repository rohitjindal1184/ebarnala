//
//  DepartmentViewController.swift
//  iRevenue
//
//  Created by MobileProgramming on 7/18/17.
//  Copyright © 2017 Rohit Jindal. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var departmentArray:[DepartmentModal] = [DepartmentModal]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        departmentArray = DepartmentModal.createArray()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DepartmentCollectionViewCell
        let obj = departmentArray[indexPath.row]
        cell?.backgroundColor = obj.backGroundColor
        cell?.imgIcon.image = obj.icon
        cell?.lblTitle.text = obj.title
        return (cell)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departmentArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 10
        let collectionCellSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var seque = ""
        if(indexPath.row == 0){
                seque = "revenue"
        }else if(indexPath.row == 1){
            seque = "food"
            self.performSegue(withIdentifier: seque, sender: "health")
            return
        }else if(indexPath.row == 2){
            seque = "police"
        }else if(indexPath.row == 3){
            seque = "food"
            self.performSegue(withIdentifier: seque, sender: "electricity")
            return
        }else if(indexPath.row == 4){
            seque = "education"
        }else if(indexPath.row == 5){
            seque = "welfare"
        }else if(indexPath.row == 6){
            seque = "food"
            self.performSegue(withIdentifier: seque, sender: "Suvida")
            return
        }else if(indexPath.row == 7){
            seque = "food"
            self.performSegue(withIdentifier: seque, sender: "Food")
            return

        }
        
        
        self.performSegue(withIdentifier: seque, sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "food"){
            let vc = segue.destination as? FoodTableViewController
            vc?.className = (sender as? String)!
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}


