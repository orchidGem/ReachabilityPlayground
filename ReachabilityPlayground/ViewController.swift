//
//  ViewController.swift
//  ReachabilityPlayground
//
//  Created by Laura Evans on 5/16/16.
//  Copyright © 2016 Laura Evans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        self.reachabilityStatusChanged()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reachabilityStatusChanged() {
        if reachabilityStatus == kNOTREACHABLE {
            
            let alertController = UIAlertController(title: "Network Error", message: "Unable to establish a network connection", preferredStyle: .Alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .Default, handler: { (UIAlertAction) in
                let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
                if let url = settingsUrl {
                    dispatch_async(dispatch_get_main_queue(), {
                        UIApplication.sharedApplication().openURL(url)
                    })
                }
            })
            
            alertController.addAction(settingsAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) in
                print("OK")
            })
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

