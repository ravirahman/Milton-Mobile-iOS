import UIKit

class Food_Flik_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var array = Array<String>()
    var numTitle: Int = 0;
    var num = 1;
    var numSectionsBreakfast = 3
    var numSectionsLunch = 5
    var numSectionsDinner = 6
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
            case 1:
                return numSectionsLunch
            case 2:
                return numSectionsDinner
            default:
                return numSectionsBreakfast
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if (indexPath.section == 0) {
            cell.textLabel?.text = "Breakfast: " + array[indexPath.row]
        }
        if (indexPath.section == 1) {
            cell.textLabel?.text = "Lunch: " + array[indexPath.row + numSectionsBreakfast]
        }
        if(indexPath.section == 2){
            cell.textLabel?.text = "Dinner: " + array[indexPath.row + numSectionsLunch]
            
        }
        
        var image : UIImage = UIImage(named: "vegetarian")!
        
        if(indexPath.row % 3 == 0){
            cell.imageView?.image = image
        }
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
            case 1:
                return "Lunch"
            case 2:
                return "Dinner"
            default:
                return "Breakfast"
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section){
            case 1:
                var alert = UIAlertController(title: "Lunch", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    switch action.style {
                        case .Default:
                            println("default")
                            break
                    
                        case .Cancel:
                            println("cancel")
                            break
                    
                        case .Destructive:
                            println("destructive")
                            break
                    }
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                break

            case 2:
                var alert = UIAlertController(title: "Dinner", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    switch action.style{
                        case .Default:
                            println("default")
                            break
                    
                        case .Cancel:
                            println("cancel")
                            break
                    
                        case .Destructive:
                            println("destructive")
                            break
                    }
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                break
            
            default:
                var alert = UIAlertController(title: "Breakfast", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    switch action.style{
                        case .Default:
                        println("default")
                        break

                    case .Cancel:
                        println("cancel")
                        break
                    
                    case .Destructive:
                        println("destructive")
                        break
                    
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

