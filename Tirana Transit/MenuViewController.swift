//
//  MenuViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 11/19/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController{

    var menuOptions = [MenuOptions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadMenuOptions()

        tableView.tableFooterView = UIView()
        
        self.hidesBottomBarWhenPushed = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.menuOptions.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) 
        
        var menuOption: MenuOptions
        
        menuOption = menuOptions[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = menuOption.title_line
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        //Add cases here to move to different segues
        
        let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell!
        
        if currentCell?.textLabel?.text == "Profile"{
        self.performSegue(withIdentifier: "profileSegue", sender: self);
        }
        else if currentCell?.textLabel?.text == "Ticket"{
        self.performSegue(withIdentifier: "ticketSegue", sender: self);
        }
        else {
        println("nothing")
        }
    }
    

    
    func loadMenuOptions(){
        
        self.menuOptions = [MenuOptions(title_line: "Profile"), MenuOptions(title_line: "Stops"), MenuOptions(title_line: "Lines"), MenuOptions(title_line: "Ticket"), MenuOptions(title_line: "Settings")]
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let indexPath = self.tableView.indexPathForSelectedRow()
        
        println(indexPath)
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
        
        println(currentCell)
        
        
        if currentCell.textLabel?.text! == "Profile" {
        performSegueWithIdentifier("profileSegue", sender: self)
            let destination
        }
        
    }*/


}
