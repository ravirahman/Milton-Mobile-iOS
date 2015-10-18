//
//  AboutScreen.swift
//  miltonmobileios
//
//  Created by Ravi Rahman on 10/18/15.
//  Copyright © 2015 Milton Academy. All rights reserved.
//

import Foundation
import UIKit

class AboutScreen {
    static func showAboutScreen(parent: UIViewController) {
        // Create the alert controller
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String

        let alertController = UIAlertController(title: "About", message: "Milton Academy Students\nv" + version, preferredStyle: .Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        let icons8creditsAction = UIAlertAction(title: "Icons by Icons8", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            UIApplication.sharedApplication().openURL(NSURL(string: "https://icons8.com")!)
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(icons8creditsAction)
        
        // Present the controller
        parent.presentViewController(alertController, animated: true, completion: nil)
    }
}
