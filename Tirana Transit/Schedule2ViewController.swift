//
//  Schedule2ViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/13/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class Schedule2ViewController: UITableViewController {

    var stops = Stops()
    
    var schedule_stops = [Schedule_Stops]() { didSet{ DispatchQueue.main.async { self.tableView.reloadData() } } }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadStopsInSchedule()
        
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.schedule_stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell2", for: indexPath) 

        // Configure the cell...
        var schedule_stop: Schedule_Stops
        
        schedule_stop = schedule_stops[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = schedule_stop.title_line
       

        return cell
    }
    
    func loadStopsInSchedule(){
        
        self.schedule_stops = [Schedule_Stops(title_line: stops.line1_stops[0]), Schedule_Stops(title_line: stops.line1_stops[1]), Schedule_Stops(title_line: stops.line1_stops[2]), Schedule_Stops(title_line: stops.line1_stops[3]), Schedule_Stops(title_line: stops.line1_stops[4]), Schedule_Stops(title_line: stops.line1_stops[5]), Schedule_Stops(title_line: stops.line1_stops[6]), Schedule_Stops(title_line: stops.line1_stops[7]), Schedule_Stops(title_line: stops.line1_stops[8]), Schedule_Stops(title_line: stops.line1_stops[9]), Schedule_Stops(title_line: stops.line1_stops[10]), Schedule_Stops(title_line: stops.line1_stops[11]), Schedule_Stops(title_line: stops.line1_stops[12]), Schedule_Stops(title_line: stops.line1_stops[13]), Schedule_Stops(title_line: stops.line1_stops[14]), Schedule_Stops(title_line: stops.line1_stops[15]), Schedule_Stops(title_line: stops.line1_stops[16])]

        
    }
    

    @IBAction func directionBarButton(_ sender: AnyObject) {
       
        callActionSheet()
    
    }
    
    
    func callActionSheet(){
        
        
        let title = "Direction"
        let message = "Choose the direction of the bus route"
        
        let optionOneText = self.stops.line1_stops.first
        
        
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        let actionOne = UIAlertAction(title: optionOneText!, style: .default){ ACTION in
            self.stops.line1_stops = self.stops.line1_stops.reversed()
            self.loadStopsInSchedule()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        
        
        actionSheet.addAction(actionOne)
        actionSheet.addAction(cancelAction)
      
        
        self.present(actionSheet, animated: true, completion: nil)
   
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        println(indexPath)
        
        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
        
        println(currentCell)
        
        // initialize new view controller and cast it as your view controller
        let schedule3VC = segue.destination as! Schedule3ViewController
        
       schedule3VC.passedValue = currentCell?.textLabel?.text!
            
       
        
    }
    
    
        // Pass the selected object to the new view controller.
    }
    

