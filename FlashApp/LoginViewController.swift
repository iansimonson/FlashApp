
//
//  LoginViewController.swift
//  FlashApp
//
//  Created by Monte's Pro 13" on 9/19/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
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

    @IBAction func loginButton(sender: AnyObject) {
        let userEmailField = userEmail.text!
        let userPasswordField = userPassword.text!
        
        
        if(userEmailField.isEmpty || userPasswordField.isEmpty ) {
            //Display alert message
            displayAlertMessage("All fields are required")
            return
        }

        // Send user data to server side
    
        let myURL: NSURL = NSURL(string: "http://reyesomar.me/FlashApp/api/user/login")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:myURL)
        request.HTTPMethod = "POST"
        
        let postString = "user=\(userEmailField)&pass=\(userPasswordField)"
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
                    var messageToDisplay:String
                    
                    if (parseJSON["success"] != nil) {
                            messageToDisplay = "Success"
                    }
                    else  {
                        messageToDisplay = parseJSON["message"] as! String!
                    
                    }
                    
                    if (messageToDisplay == "Success") {
                        
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else {
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




