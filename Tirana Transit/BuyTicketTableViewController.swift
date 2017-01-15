//
//  BuyTicketTableViewController.swift
//  Tirana Transit
//
//  Created by Etjen Ymeraj on 11/22/15.
//  Copyright (c) 2015 Etjen Ymeraj. All rights reserved.
//

import UIKit

class BuyTicketTableViewController: UITableViewController,  PayPalPaymentDelegate{
    
    // For PayPal integration, we need to follow these steps
    // 1. Add Paypal config. in AppDelegate
    // 2. Create PayPal object
    // 3. Declare payment configurations
    // 4. Implement PayPalPaymentDelegate
    // 5. Add payment items and related details
    
    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    var ticketOptions = [TicketOptions]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTicketOptions()
        
        tableView.tableFooterView = UIView()
        
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Etjen Ymeraj"
        //payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.sivaganesh.com/privacy.html")
        //payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.sivaganesh.com/useragreement.html")
        payPalConfig.languageOrLocale = Locale.preferredLanguages()[0] as! String
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        PayPalMobile.preconnectWithEnvironment(environment)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTicketOptions(){
        
        self.ticketOptions = [TicketOptions(title_line: "Single Ticket Adult", description_line: "Valid for one person from 15 years of age and up for one journey"), TicketOptions(title_line: "Single Ticket Child", description_line: "Valid for one person (6-14 years of age) and up for one journey"), TicketOptions(title_line: "Single Ticket Student", description_line: "Valid for one person with a valid student card for one journey"), TicketOptions(title_line: "Monthly Ticket Adult", description_line: "Valid for one person from 15 years of age and up for any number of journeys on the selected day until the thirtyfirst day"), TicketOptions(title_line: "Monthly Ticket Child", description_line: "Valid for one person (6-14 years of age) and up for any number of journeys on the selected day until the thirtyfirst day"),  TicketOptions(title_line: "Monthly Ticket Student", description_line: "Valid for one person with a valid student card for any number of journeys on the selected day until the thirtyfirst day")]
    
    }

    // MARK: - Table view data source

    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController!) {
        println("PayPal Payment Cancelled")
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        
        println("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmaion to your server
            println("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            var alert = UIAlertView(title: "Payment Succesful", message: "\(completedPayment.confirmation)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.ticketOptions.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        //Add cases here to move to different segues
        
        let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell!
        
        // Process Payment once the pay button is clicked.
        
        var item1 = PayPalItem(name: "Test Item", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.99"), withCurrency: "USD", withSku: "SivaGanesh-0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Test", intent: .Sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController, animated: true, completion: nil)
        }
        else {
            
            println("Payment not processalbe: \(payment)")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) 
        
        var ticketOption: TicketOptions
        
        ticketOption = ticketOptions[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = ticketOption.title_line
        cell.detailTextLabel?.text = ticketOption.description_line
        
        
        cell.detailTextLabel?.numberOfLines = 3;
        
        return cell
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
