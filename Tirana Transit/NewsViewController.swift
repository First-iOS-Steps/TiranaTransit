//
//  NewsViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/9/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    //var news: Alerts?
    
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textField.text = passedValue
 }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
