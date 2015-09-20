
//
//  AddCriteriaViewController.swift
//  FlashApp
//
//  Created by Monte's Pro 13" on 9/20/15.
//  Copyright © 2015 Monte Thakkar. All rights reserved.
//

import UIKit

class AddCriteriaViewController: UIViewController {

    @IBOutlet weak var language: UITextField!
    @IBOutlet weak var industry: UITextField!
    @IBOutlet weak var years_experience: UITextField!
    
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
    
    
    @IBAction func FlashButton(sender: AnyObject) {
        let languageField = language.text!
        let industryField = industry.text!
        let years_experienceField = years_experience.text!
        
        //Check for empty fields
        if(languageField.isEmpty || industryField.isEmpty ||  years_experienceField.isEmpty) {
            //Display alert message
            displayAlertMessage("All fields are required")
            return
        }
        var myAlert = UIAlertController(title: "Alert", message: "Moving on", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction (title: "OK", style: UIAlertActionStyle.Default) {
            action in
            self.performSegueWithIdentifier("displayUsers", sender: self)
        }
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        //Store Data
//        let myURL: NSURL = NSURL(string: "http://104.245.36.70/FlashApp/api/user/register")!
//        let request: NSMutableURLRequest = NSMutableURLRequest(URL:myURL)
//        request.HTTPMethod = "POST"
//        
//        let postString = "userid=\(userid)langauge=\(languageField)industry=\(industryField)years_exp=\(years_experienceField)"
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//            data, response, error in
            
//            if(error != nil){
//                print("error=\(error)")
//                return
//            }
//            
//            
//            do {
//                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
//                print(json)
//                
//                if let parseJSON = json {
//                    var resultValue=parseJSON["status"] as? String
//                    print("result=\(resultValue)")
//                    
//                    var messageToDisplay:String = parseJSON["message"] as! String!
//                    }
//                    
//                    
//                    dispatch_async(dispatch_get_main_queue(), {
//                        //Display alert message with confirmation
//                        var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert)
//                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
//                            action in
//                            self.dismissViewControllerAnimated(true, completion: nil)
//                        }
//                        
//                        myAlert.addAction(okAction)
//                        self.presentViewController(myAlert, animated: true, completion: nil)
//                    })
//                }
//            } catch let error as NSError {
//                print(error)
//            }
//            
//            
//            
//        }
//        
//        task.resume()
    }

}
