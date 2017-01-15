//
//  AlertsViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/9/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class AlertsViewController: UITableViewController {
    
    var alerts = [Alerts]()
    
    var lines = Lines()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alerts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        var alert: Alerts
        
        alert = alerts[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = alert.title_line
        cell.detailTextLabel?.text = alert.description_line
        cell.imageView?.image = alert.image_line
        
        return cell
        
        
    }
    
    func loadAlerts(){
        let photo1 = UIImage(named: "line7")
        let photo2 = UIImage(named: "line5")
        let photo3 = UIImage(named: "line3")
        let photo4 = UIImage(named: "line8")
        
        
        self.alerts = [Alerts(title_line: lines.lineNr[6], description_line: "Direction: Instituti Bujqesor", image_line: photo1!), Alerts(title_line: lines.lineNr[4], description_line: "Direction: Sauk", image_line: photo2!), Alerts(title_line: lines.lineNr[2], description_line: "Direction: Unaza", image_line: photo3!), Alerts(title_line: lines.lineNr[7], description_line: "Direction: Laprak", image_line: photo4!)]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        println(indexPath)
        
        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
        
        println(currentCell)
        
        // initialize new view controller and cast it as your view controller
        let newsVC = segue.destination as! NewsViewController
        
        if currentCell?.textLabel?.text! == "Line 7" {
            
            newsVC.passedValue = "Line 7 has a problem"
        }
        else if currentCell?.textLabel?.text! == "Line 5"{
            newsVC.passedValue = "Line 5 has a problem"
            
        }   else if currentCell?.textLabel?.text! == "Line 3"{
            newsVC.passedValue = "Line 3 has a problem"
            
            
        }   else if currentCell?.textLabel?.text! == "Line 8"{
            
            newsVC.passedValue = "Line 8 has a problem"
            
        }   else {
            newsVC.passedValue = "This line has a problem"
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


