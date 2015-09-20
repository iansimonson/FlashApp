
//
//  RegisterPageViewController.swift
//  FlashApp
//
//  Created by Monte's Pro 13" on 9/19/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var repeatUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertMessage(userMessage: String) {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func registerButton(sender: AnyObject) {
        let userEmailField = userEmail.text!
        let userPasswordField = userPassword.text!
        let userRepeatPasswordField = repeatUserPassword.text!
    
        //Check for empty fields
        if(userEmailField.isEmpty || userPasswordField.isEmpty ||  userRepeatPasswordField.isEmpty) {
            //Display alert message
            displayAlertMessage("All fields are required")
            return
        }
        
        if (userPasswordField != userRepeatPasswordField) {
            //Dispay an alert message
            print(userPasswordField)
            print(userRepeatPasswordField)
            displayAlertMessage("Passwords do not match!")
            return
        }
        
        //Store Data
        let myURL: NSURL = NSURL(string: "http://104.245.36.70/FlashApp/api/user/register")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:myURL)
        request.HTTPMethod = "POST"
        
        let postString = "user=\(userEmailField)&pass=\(userPasswordField)&pass2=\(userRepeatPasswordField)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if(error != nil){
                print("error=\(error)")
                return
            }
        
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                print(json)
                
            if let parseJSON = json {
                var resultValue=parseJSON["status"] as? String
                print("result=\(resultValue)")
            
                var isUserRegistered: Bool = false
                if(resultValue == "Success") {
                    isUserRegistered = true
                }
                var messageToDisplay:String = parseJSON["message"] as! String!
                if(!isUserRegistered) {
                    messageToDisplay = parseJSON["message"] as! String!
                }
                
            
                dispatch_async(dispatch_get_main_queue(), {
                    //Display alert message with confirmation
                    var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                        action in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                })
            }
            } catch let error as NSError {
                print(error)
            }
            

        
        }
        
        task.resume()
    }
}
