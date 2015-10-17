import UIKit
import Alamofire

class Food_Meals_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {

    var TableData : JSON = []
    var selectedTime = "Lunch"
    var date = ""
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let tableAsDictionary = TableData[selectedTime].dictionaryValue
        return tableAsDictionary.count
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
        var tableAsDictionary = TableData[selectedTime].dictionaryValue
        let key : String = Array(tableAsDictionary.keys)[section]
        let testc = tableAsDictionary[key]!.count
        return testc
    }
    @IBAction func mealTimeChanged(sender: UISegmentedControl) {
        self.selectedTime = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        self.tableView.reloadData()
    }

    @IBOutlet weak var MealTimeSegmentedControl: UISegmentedControl!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let tableAsDictionary = TableData[selectedTime].dictionaryValue
        let key : String = Array(tableAsDictionary.keys)[indexPath.section]
        
        let labelt = TableData[selectedTime][key][indexPath.row]["mealName"].stringValue
        
        cell.textLabel?.text = labelt
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableAsDictionary = TableData[selectedTime].dictionaryValue
        let key : String = Array(tableAsDictionary.keys)[section]
        return key
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertView();
        alert.title = "Meal Name"
        
        let tableAsDictionary = TableData[selectedTime].dictionaryValue
        let key : String = Array(tableAsDictionary.keys)[indexPath.section]
        
        let labelt = TableData[selectedTime][key][indexPath.row]["mealName"].stringValue
        
        alert.message = labelt
        
        alert.addButtonWithTitle("Dismiss")
        alert.show()
        self.tableView.resignFirstResponder()

    }

    @IBOutlet weak var tableView: UITableView!

    func loadMeals() {
        SwiftSpinner.show("Loading Meals");
        let d1 = ["mealName":"None Entered"]
        let d2 = [d1]
        let d3 = ["Flik":d2]
        let d4 = JSON(d3)
        
        Alamofire.request(.GET,"http://flik.ma1geek.org/getMeals.php", parameters:["date":self.date,"version":2]).responseJSON{response in
            SwiftSpinner.hide();
            if let data = response.2.value {
                var jsoncontent = JSON(data)
                if jsoncontent["Breakfast"] == nil {
                    jsoncontent["Breakfast"] = d4
                }
                if jsoncontent["Lunch"] == nil {
                    jsoncontent["Lunch"] = d4
                }
                if jsoncontent["Dinner"] == nil {
                    jsoncontent["Dinner"] = d4
                }
                self.TableData = jsoncontent
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    return
                })
                //format of dictionary mealtimes:
                //{mealtime:{mealclass:[menuitems],mealcalss2:[menuitems]},mealtime2:{mealclass:[menuitems],mealcalss2:[menuitems]}
                //for example:
                //{Lunch:{Entree:[Hamburgers, Hot Dogs, French Fries], Flik Live: Caesar Wraps},Dinner:{Entree: [Good ol' plain pasta, Yummy carrot sticks],Dessert:[Pink Ice Cream, Dog Biscuits]}}
                //TODO Justin please populate the table using this format
                //mealtimes and categories are SwiftyJSON Objects -- see https://github.com/SwiftyJSON/SwiftyJSON

            }
            else {
                let alert = UIAlertView();
                alert.title = "Try again"
                alert.message = "Please check your network connection."
                alert.addButtonWithTitle("OK")
                alert.show()
            }
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let date = NSDate() //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
        let dateString = dateFormatter.stringFromDate(date)
        self.date = dateString
        loadMeals()
    }
}

