//
//  Schedule3ViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/17/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class Schedule3ViewController: UITableViewController {
    
    var passedValue: String!
    
    var stops = Stops()
    
    
    var topItems = [String]()
    var time =  [String]()
    var subItems = [[String]]()
    var topDetailItems = [String]()
    
    var currentItemsExpanded = [Int]()
    var actualPositions = [Int]()
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let index = find(stops.line1_stops, passedValue)
        
        if index==0{
            time = stops.line1_stop1_times
        }else{
            time = stops.line1_stop2_times
        }

        
        for i in 0 ..< time.count{
            topItems.append(passedValue)
            
            var tString: String = time[i]
            var tStringArr = tString.components(separatedBy: ":")
            
            topDetailItems.append(tStringArr[0]+":"+tStringArr[1])
            actualPositions.append(-1)
            
            var items = [String]()
            for (var i = index!+1; i < stops.line1_stops.count; i++) {
                items.append("\(stops.line1_stops[i])")
            }
            
            self.subItems.append(items)
        }
        total = topItems.count
        
        tableView.tableFooterView = UIView()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func infoBarButton(_ sender: AnyObject) {
        let alertTitle = "Important Information"
        let alertMessage = "Line: 1 \n First Departure: 6h15 \n Last Departure: 01h15 \n Direction: Kinostudio"
        let alertText = "Continue"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let continueButton = UIAlertAction(title: alertText, style: .cancel, handler: nil)
        
        alert.addAction(continueButton)
        present(alert, animated: true, completion: nil)
        
    }
   
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.total
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var parentCellIdentifier = "ParentCell"
        var childCellIdentifier = "ChildCell"
        
        var parent = self.findParent((indexPath as NSIndexPath).row)
        var idx = find(self.currentItemsExpanded, parent)
        
        var isChild = idx != nil && (indexPath as NSIndexPath).row != self.actualPositions[parent]
        
        var cell : UITableViewCell!
        
        
        if isChild {
            cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) 
            cell.textLabel!.text = self.subItems[parent][(indexPath as NSIndexPath).row - self.actualPositions[parent] - 1]
            cell.imageView!.image = UIImage(named: "right arrow59.png")
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier, for: indexPath) 
            var topIndex = self.findParent((indexPath as NSIndexPath).row)
            
            cell.textLabel!.text = self.topItems[topIndex]
                cell.detailTextLabel!.text = self.topDetailItems[topIndex]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var parent = self.findParent((indexPath as NSIndexPath).row)
        var idx = find(self.currentItemsExpanded, parent)
        var isChild = idx != nil
        
        if (indexPath as NSIndexPath).row == self.actualPositions[parent]{
            isChild = false
        }
        
        if (isChild) {
            NSLog("A child was tapped!!!");
            return;
        }
        
        self.tableView.beginUpdates()
        
        if let value = find(self.currentItemsExpanded, self.findParent((indexPath as NSIndexPath).row)) {
            
            self.collapseSubItemsAtIndex((indexPath as NSIndexPath).row)
            self.actualPositions[parent] = -1
            self.currentItemsExpanded.remove(at: value)
            
            for i in parent + 1 ..< self.topItems.count{
                if self.actualPositions[i] != -1 {
                    self.actualPositions[i] -= self.subItems[parent].count
                }
            }
        }
        else {
            var parent = self.findParent((indexPath as NSIndexPath).row)
            
            self.expandItemAtIndex((indexPath as NSIndexPath).row)
            self.actualPositions[parent] = (indexPath as NSIndexPath).row
            
            for i in parent + 1 ..< self.topItems.count{
                if self.actualPositions[i] != -1 {
                    self.actualPositions[i] += self.subItems[parent].count
                }
            }
            self.currentItemsExpanded.append(parent)
        }
        
        self.tableView.endUpdates()
    }
    
    
    fileprivate func expandItemAtIndex(_ index : Int) {
        
        var indexPaths = [IndexPath]()
        
        let val = self.findParent(index)
        
        let currentSubItems = self.subItems[val]
        var insertPos = index + 1
        
        for i in 0 ..< currentSubItems.count {
            indexPaths.append(IndexPath(row: insertPos++, section: 0))
        }
        
        self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        self.total += self.subItems[val].count
    }
    
    fileprivate func collapseSubItemsAtIndex(_ index : Int) {
        
        var indexPaths = [IndexPath]()
        let parent = self.findParent(index)
        
        for (var i = index + 1; i <= index + self.subItems[parent].count; i += 1 ){
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        
        self.tableView.deleteRows(at: indexPaths, with: UITableViewRowAnimation.fade)
        self.total  -= self.subItems[parent].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var parent = self.findParent((indexPath as NSIndexPath).row)
        var idx = find(self.currentItemsExpanded, parent)
        
        var isChild = idx != nil && (indexPath as NSIndexPath).row != self.actualPositions[parent]
        
        if (isChild) {
            return 44.0
        }
        return 54.0
    }
    
    fileprivate func findParent(_ index : Int) -> Int {
        
        var parent = 0
        var i = 0
        
        while (true) {
            
            if (i >= index) {
                break
            }
            
            // if is opened
            if let idx = find(self.currentItemsExpanded, parent) {
                i += self.subItems[parent].count + 1
                
                if (i > index) {
                    break
                }
            }
            else {
                i += 1
            }
            
            parent += 1
        }
        
        return parent
    }
    
}
