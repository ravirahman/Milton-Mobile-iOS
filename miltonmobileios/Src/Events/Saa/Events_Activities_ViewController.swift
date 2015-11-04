import UIKit
import Alamofire

class Events_Activities_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var TableData : JSON = []
    var date = ""
    var today = "";
    
    @IBOutlet var dayController: UISegmentedControl!
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    @IBAction func dateChanged(sender: UISegmentedControl) {
        var date = NSDate() //get the time, in this case the time an object was created.
        //format date
        //let dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        //let dateString = dateFormatter.stringFromDate(date)
        //self.date = dateString
        switch sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!{
        case "Monday":
            date = date.following(weekday: .Monday)
            
        case "Tuesday":
            date = date.following(weekday: .Tuesday)
            
        case "Wednesday":
            date = date.following(weekday: .Wednesday)
            
        case "Thursday":
            date = date.following(weekday: .Thursday)
            
        case "Friday":
            date = date.following(weekday: .Friday)
            
        default:
            break
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.stringFromDate(date)
        //print(dateString)
        self.date = dateString
        loadActivities()
        

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableAsArray = TableData["Activities"].arrayValue
        return tableAsArray.count
 /*
        var tableAsDictionary = TableData["Activities"].arrayValue
        var key : String = Array(tableAsDictionary.keys)[section]
        var testc = tableAsDictionary[key]!.count
        return testc*/
    }
    /*@IBAction func mealTimeChanged(sender: UISegmentedControl) {
        self.selectedTime = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        self.tableView.reloadData()
    }*/
    
    //@IBOutlet weak var MealTimeSegmentedControl: UISegmentedControl!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var activityJO = TableData["Activities"][indexPath.row]
        let eventName = activityJO["eventName"].stringValue
        
        cell.textLabel?.text = eventName
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Activities"
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var activityJO = TableData["Activities"][indexPath.row]
        let eventName = activityJO["eventName"].stringValue
        let eventDesc = activityJO["eventDescription"].stringValue
        let startTime = activityJO["startTime"].stringValue
        let endTime = activityJO["endTime"].stringValue
        let location = activityJO["eventLocation"].stringValue
        
        let alert = UIAlertView();
        alert.title = eventName
        let labelt = eventDesc + "\n" + "Location: " + location + "\n\n" + "Start Time: " + startTime + "\n\n" + "End Time: " + endTime
        
        alert.message = labelt
        
        alert.addButtonWithTitle("Dismiss")
        alert.show()
        self.tableView.resignFirstResponder()
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let date = NSDate() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.stringFromDate(date)
        self.date = dateString
        loadActivities()
    }
    override func viewDidLoad() {
        let date=NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let currentDay = dateFormatter.stringFromDate(date)
        print(currentDay)
        dayController.selectedSegmentIndex = getIntValueFromDay(currentDay)
    }
    @IBAction func navbarclicked(sender: AnyObject) {
        AboutScreen.showAboutScreen(self)
    }
    func getIntValueFromDay(weekday:String) -> Int{
        switch weekday{
        case "Monday":
            return 0
            
        case "Tuesday":
            return 1
            
        case "Wednesday":
            return 2
            
        case "Thursday":
            return 3
            
        case "Friday":
            return 4
            
        default:
            return 0
        }
        
    }
    
    func loadActivities() {
        if (today != self.date) {
            today = self.date;
            SwiftSpinner.show("Loading Activities");
        }
        
        Alamofire.request(.GET,"http://saa.ma1geek.org/getActivities.php", parameters:["date":self.date]).responseJSON{response in
            SwiftSpinner.hide();
            if let data = response.2.value {
            let json = JSON(data)
            self.TableData = json
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                return
            })
            // see https://github.com/SwiftyJSON/SwiftyJSON
            }
            else {
                let alert = UIAlertView();
                alert.title = "Try again"
                alert.message = "Please check your network connection to load the latest activities."
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

