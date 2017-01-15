//
//  ProfileViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 11/19/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet weak var logOut: UIButton!
    
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        println("Login")
        
        if (PFUser.currentUser() == nil) {
        logOut.isHidden = true
        }
        
        if (PFUser.currentUser() != nil) {
            println(PFUser.currentUser()?.username)
            self.label.center = CGPoint(x: 185, y: 471)
            self.label.textAlignment = NSTextAlignment.center
            self.label.text = PFUser.currentUser()?.username
            self.label.isHidden = false
            self.view.addSubview(self.label)
        }
        
        
    }
    
    func changeLabel(){
        self.usernameLabel.text = PFUser().username
    }

    @IBAction func logInButton(_ sender: AnyObject) {
        var username = self.usernameTextField.text
        var password = self.passwordTextField.text
        
        // Validate the text fields
        if count(username) < 5 {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if count(password) < 8 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                   //self.usernameLabel.description = username
                   //self.usernameLabel.hidden=false
                    self.logOut.hidden = false
                    
                    //var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                    self.label.center = CGPointMake(185, 471)
                    self.label.textAlignment = NSTextAlignment.Center
                    self.label.text = username
                    self.label.hidden = false
                    self.view.addSubview(self.label)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                } else {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
            })
        }
    }
    
    @IBAction func logOutButton(_ sender: AnyObject) {
        
        PFUser.logOut()
        var user = PFUser.currentUser()
        println(user)
        var alert = UIAlertView(title: "Success", message: "Logged Out", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        logOut.isHidden = true
        self.label.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*func logInViewController(logInController: PFLogInViewController, shouldBeginLoginWithUsername username: String!, password: String!) -> Bool{
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser: PFUser){
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError!){
        
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
