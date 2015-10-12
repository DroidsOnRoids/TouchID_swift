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
                            self.showAlert("Error", message: "Oops! There was a problem verifying your identity :(")
                        } else {
                            if success {
                                self.showAlert("Success", message: "This is your device!")
                            } else {
                                self.showAlert("Error", message: "You are not the device owner.")
                            }
                        }
                    })
            })
        } else {
            showAlert("Error", message: "Touch ID is not supported on that device")
        }
    }
    
    func showAlert(title: String, message: String) {
        let testAlert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
        testAlert.addAction(action)
        self.presentViewController(testAlert, animated: true, completion: nil)
    }
}