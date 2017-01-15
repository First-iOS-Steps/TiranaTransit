//
//  DeparturesViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/7/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class DeparturesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var choicesTextField: UITextField!
    
    @IBOutlet weak var choicesTable: UITableView!
    
    var picker = UIPickerView()
    
    var departures = [Departures]()
    
    var stops = Stops()
    
    var choices = [String]()
    
    let date = Date()
    
    var timeArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        choicesTextField.inputView = picker
        
        choicesTable.isHidden = true
        choicesTable.tableFooterView = UIView()
        
        choices = stops.line1_stops
        
        
        loadDepartures()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func timeLeft(_ currentTime: String, station: String) -> Array<String> {
        
        var cString: String = currentTime
        var cStringArr = cString.components(separatedBy: ":")
        
        var timeArr = [String]()
        
        var tempArr = [String]()
        
        let index = find(stops.line1_stops, station)
        
        println(index)
        
        if index==0{
            tempArr = stops.line1_stop1_times
        }else{
            tempArr = stops.line1_stop2_times
        }
        
        for times in tempArr {
            var pString: String = times
            var pStringArr = pString.components(separatedBy: ":")
            
            var p = pStringArr[0].toInt()!*3600+pStringArr[1].toInt()!*60+pStringArr[2].toInt()!
            var c = cStringArr[0].toInt()!*3600+cStringArr[1].toInt()!*60+cStringArr[2].toInt()!
            
            var difference = p-c
            
            var hour: Int = difference/3600
            var minute: Int = difference/60
            var minutes_left: Int = minute%60
            var second: Int = difference%60
    
            if (hour==0&&minute>0){
                println("\(minute) Min\n")
                timeArr.append("\(minute) Min\n")
            }
            else if (hour==0&&minute==0){
                println("\(second) Sec\n")
                timeArr.append("\(second) Sec\n")
            }
        

        }
        println(station)
        return timeArr
    }
    
    
    func getCurrentTime() -> String {
        
        let calendar = Calendar.current
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        return("\(hour):\(minute):\(second)")
    }

    func loadDepartures(){
        for i in timeArr{
        self.departures += [Departures(title_line: choicesTextField.text!, description_line: i)]
        }
    }

    func clearTable(){
      self.departures = [Departures(title_line: "", description_line: "")]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        picker.backgroundColor = UIColor.white
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        choicesTextField.text = choices[row]
        clearTable()
        timeArr = timeLeft(getCurrentTime(), station: choicesTextField.text!)
        loadDepartures()
        choicesTable.reloadData()
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.departures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.choicesTable.dequeueReusableCell(withIdentifier: "DeparturesCell", for: indexPath) 
        
        var departure: Departures
        
        departure = departures[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = departure.title_line
        cell.detailTextLabel!.text = departure.description_line

        
        return cell
    }
    
    
    
    @IBAction func showDeparturesButton(_ sender: AnyObject) {
            choicesTable.isHidden = false
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
