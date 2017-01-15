//
//  ViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 10/7/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

var myFirstLabel: UILabel!
var mySecondLabel: UILabel!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func addLabels(){
        
        myFirstLabel = UILabel()
        myFirstLabel.text = "Tirana"
        myFirstLabel.font = UIFont(name: "Helvetica Neue", size: 40)
        myFirstLabel.textColor = UIColor.white
        myFirstLabel.sizeToFit()
        myFirstLabel.center = CGPoint(x: 170, y: 35)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            myFirstLabel.center = CGPoint(x: 170, y: 35 + 200)
            
            
            }, completion: nil)
        
        mySecondLabel = UILabel()
        mySecondLabel.text = "Transit"
        mySecondLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        mySecondLabel.sizeToFit()
        mySecondLabel.textColor = UIColor.white
        mySecondLabel.center = CGPoint(x: 75, y: 280)
        mySecondLabel.alpha = 0
        
        UIView.animateWithDuration(2.0, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: nil, animations: {
            
            mySecondLabel.alpha = 1
            mySecondLabel.center = CGPoint(x: 75 + 70, y: 280)
            
            
            }, completion: nil)
        
        view.addSubview(myFirstLabel)
        view.addSubview(mySecondLabel)
    
    

}
}

