//
//  ScheduleViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/7/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {
    
    var lines = Lines()
    
    var schedule_lines = [Schedule_Lines]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadLinesInSchedule()
        
        tableView.tableFooterView = UIView()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schedule_lines.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bus"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) 
        
        var schedule_line: Schedule_Lines
        
        schedule_line = schedule_lines[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = schedule_line.title_line
        cell.detailTextLabel?.text = schedule_line.description_line
        cell.imageView?.image = schedule_line.image_line
        
        
        return cell
        
        
    }
    
    
    func loadLinesInSchedule(){
        
        let photo1 = UIImage(named: "line1")
        let photo2 = UIImage(named: "line2")
        let photo3 = UIImage(named: "line3")
        let photo4 = UIImage(named: "line4")
        let photo5 = UIImage(named: "line5")
        let photo6 = UIImage(named: "line6")
        let photo7 = UIImage(named: "line7")
        let photo8 = UIImage(named: "line8")
        let photo9 = UIImage(named: "line9")
        let photo11 = UIImage(named: "line11")
        
        
        self.schedule_lines = [Schedule_Lines(title_line: lines.lineNr[0], description_line: "Directions: Sheshi Kombinat / Kinostudio", image_line: photo1!), Schedule_Lines(title_line: lines.lineNr[1], description_line: "Directions: Kullat Binjake / Qender", image_line: photo2!), Schedule_Lines(title_line: lines.lineNr[2], description_line: "Directions: Parku Rinia / Parlamenti", image_line: photo3!), Schedule_Lines(title_line: lines.lineNr[3], description_line: "Directions: Qender / Porcelani", image_line: photo4!), Schedule_Lines(title_line: lines.lineNr[4], description_line: "Directions: Qender / Sauk", image_line: photo5!), Schedule_Lines(title_line: lines.lineNr[5], description_line: "Directions: Qender / Uzina e Autotraktorve", image_line: photo6!), Schedule_Lines(title_line: lines.lineNr[6], description_line: "Directions: Qender / Universiteti Bujqesor", image_line: photo7!), Schedule_Lines(title_line: lines.lineNr[7], description_line: "Directions: Qender / Lapraka", image_line: photo8!), Schedule_Lines(title_line: lines.lineNr[8], description_line: "Directions: Qender / Tufine", image_line: photo9!), Schedule_Lines(title_line: lines.lineNr[9], description_line: "Directions: Uzina Dinamo / Sharre", image_line: photo11!)]
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
