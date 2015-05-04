//
//  ViewController.swift
//  Flik Template
//
//  Created by Justin Schwaitzberg on 4/21/15.
//  Copyright (c) 2015 Justin Schwaitzberg. All rights reserved.
//

import UIKit

class ViewControllerSAA: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var array = Array<String>()
    
    
    var numTitle: Int = 0;
    
    var num = 1;
    
    var numSectionsFriday = 2
    var numSectionsSaturday = 5
    var numSectionsSunday = 3
    
    
    var imageThing : UIImageView?
    
    func populateArray(){
        
        
        
        for(var i = 0; i <= 30; i++){
            
            
            array.append("data" + String(num));
            
            
            num = num + 1;
        }
        
        
        
        
        
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
            
            
            
        case 1: return numSectionsSaturday
        case 2: return numSectionsSunday
            
        default: return numSectionsFriday
            
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        
        if(indexPath.section == 0){
            cell.textLabel?.text = "Friday: " + array[indexPath.row]
            
        }
        if(indexPath.section == 1){
            cell.textLabel?.text = "Saturday: " + array[indexPath.row + numSectionsFriday]
            
        }
        if(indexPath.section == 2){
            cell.textLabel?.text = "Sunday: " + array[indexPath.row + numSectionsSaturday]
            
        }
        

        
        
        
        
        
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        
        
        switch(section){
            
            
            
            
            
            
        case 1:
            return "Saturday"
            
            
        case 2:
            return "Sunday"
            
            
        default:
            
            return "Friday"
            
            
            
            
            
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        switch(indexPath.section){
            
        case 1:
            
            
            
            var alert = UIAlertController(title: "Saturday", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    println("default")
                    
                case .Cancel:
                    println("cancel")
                    
                case .Destructive:
                    println("destructive")
                }
            }))
            
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            break;
            
        case 2:
            
            
            
            var alert = UIAlertController(title: "Sunday", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    println("default")
                    
                case .Cancel:
                    println("cancel")
                    
                case .Destructive:
                    println("destructive")
                }
            }))
            
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            break;
            
            
        default:
            
            
            
            var alert = UIAlertController(title: "Friday", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    println("default")
                    
                case .Cancel:
                    println("cancel")
                    
                case .Destructive:
                    println("destructive")
                }
            }))
            
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            break;
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        populateArray()
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

