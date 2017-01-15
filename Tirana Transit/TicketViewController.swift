//
//  TicketViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 11/21/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TicketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("Ticket")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buyTicketButton(_ sender: AnyObject) {
        if (PFUser.currentUser() == nil) {
            var alert = UIAlertView(title: "Ups...", message: "You must login first", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") 
                self.present(viewController, animated: true, completion: nil)
            })
        }
        
        
        var user = PFUser.currentUser()
        println(user)
        

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
