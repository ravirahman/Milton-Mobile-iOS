//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class CenterViewController: UIViewController, SidePanelViewControllerDelegate {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var creatorLabel: UILabel!
    
    var delegate: CenterViewControllerDelegate?

    // MARK: Button actions
    
    @IBAction func kittiesTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    @IBAction func puppiesTapped(sender: AnyObject) {
    }
    
    func animalSelected(animal: Animal) {
        //THIS IS HOW TO TOGGL WHEN STUFF HAPPENS
        switch animal.title {
        case "SAA":
            // print("SAA")
            
            
            performSegueWithIdentifier("saa_segue", sender: self)

            var i=0
        case "FLIK":
            performSegueWithIdentifier("flik_segue", sender: self)

            
            var i=0
        case "Mailbox":
                        performSegueWithIdentifier("mailbox_segue", sender: self)
            // print("MMMMMMMailbox")
            var i=0
        case "Settings":
            // print("Settings")
                        performSegueWithIdentifier("settings_segue", sender: self)
            var i=0
        default:
            // print("WHAT")
            var i=0
        }
        
        
        imageView.image = animal.image
        titleLabel.text = animal.title
        creatorLabel.text = animal.creator
        
        delegate?.collapseSidePanels?()
    }
}