import UIKit
import Alamofire

class Events_Saa_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var TableData : JSON = []
    var date = ""
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    @IBAction func datePickerClicked(sender: UIBarButtonItem) {
        // Create alert
        
        /*    var alert = UIAlertView(title: "Select Date", message: "Select Date", delegate: , cancelButtonTitle: "Cancel", otherButtonTitles: "OK",nil)
        
        // Create date picker (could / should be an ivar)
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, alert.bounds.size.height, 320, 216)];
        // Add picker to alert
        [alert addSubview:picker];
        // Adjust the alerts bounds
        alert.bounds = CGRectMake(0, 0, 320 + 20, alert.bounds.size.height + 216 + 20);*/
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = NSDate() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.stringFromDate(date)
        self.date = dateString
        loadActivities()
    }
    func loadActivities() {
        
        Alamofire.request(.GET,"http://saa.ma1geek.org/getActivities.php", parameters:["date":self.date]).responseJSON{response in
            let data = response.2.value;
            let json = JSON(data!)
            self.TableData = json
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                return
            })
            // see https://github.com/SwiftyJSON/SwiftyJSON
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

