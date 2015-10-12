//
//  ViewController.swift
//  DORTouchID_swift
//
//  Created by Marcin Jackowski on 08/10/15.
//  Copyright © 2015 DroidsOnRoids. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchIDButtonTapped(sender: UIButton) {
        evaluateWithPolicy(.DeviceOwnerAuthenticationWithBiometrics)
    }
    
    @IBAction func touchIDPasscodeButtonTapped(sender: UIButton) {
        evaluateWithPolicy(.DeviceOwnerAuthentication)
    }
    
    func evaluateWithPolicy(policy: LAPolicy) {
        let context = LAContext()
        let error = NSErrorPointer()
        
        if context.canEvaluatePolicy(policy, error: error) {
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Prove that you're a device owner.",
                reply: { (success, error) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if let _ = error {
                            let alert = UIAlertController(title: "Error", message: "Oops! There was a problem verifying your identity :(", preferredStyle: .Alert)
                            let action = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
                            alert.addAction(action)
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else {
                            if success {
                                let alert = UIAlertController(title: "Success", message: "This is your device!", preferredStyle: .Alert)
                                let action = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
                                alert.addAction(action)
                                self.presentViewController(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Error", message: "You are not the device owner.", preferredStyle: .Alert)
                                let action = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
                                alert.addAction(action)
                                self.presentViewController(alert, animated: true, completion: nil)
                            }
                        }
                        
                        
                    })
            })
        } else {
            let testAlert = UIAlertController(title: "Error", message: "Touch ID is not supported on that device", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
            testAlert.addAction(action)
            self.presentViewController(testAlert, animated: true, completion: nil)
        }
    }
}

