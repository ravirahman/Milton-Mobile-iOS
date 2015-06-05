import UIKit
import Alamofire

class Food_Flik_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    var numTitle: Int = 0;
    var num = 1;
    var imageThing : UIImageView?
    var TableData : JSON = []

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var tableAsDictionary = TableData.dictionaryValue
        return tableAsDictionary.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableAsDictionary = TableData.dictionaryValue
        var key : String = Array(tableAsDictionary.keys)[section]
        return tableAsDictionary[key]!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        /*if (indexPath.section == 0) {
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
        */
        return cell;
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*switch(section){
            case 1:
                return "Lunch"
            case 2:
                return "Dinner"
            default:
                return "Breakfast"
        }*/
        return "b"
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*switch(indexPath.section){
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
            
            default:*/
                /*var alert = UIAlertController(title: indexPath.item, "Breakfast", message: "Selected " + (array[indexPath.row]), preferredStyle: UIAlertControllerStyle.Alert)

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
               // break;
     //   } */

    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET,"http://flik.ma1geek.org/getMeals.php", parameters:["date":"2015-05-22","version":2]).responseJSON{(_,_,data,_) in
            self.TableData = JSON(data!);
            self.populateTableData()
            //format of dictionary mealtimes:
            //{mealtime:{mealclass:[menuitems],mealcalss2:[menuitems]},mealtime2:{mealclass:[menuitems],mealcalss2:[menuitems]}
            //for example:
            //{Lunch:{Entree:[Hamburgers, Hot Dogs, French Fries], Flik Live: Caesar Wraps},Dinner:{Entree: [Good ol' plain pasta, Yummy carrot sticks],Dessert:[Pink Ice Cream, Dog Biscuits]}}
            //TODO Justin please populate the table using this format
                //mealtimes and categories are SwiftyJSON Objects -- see https://github.com/SwiftyJSON/SwiftyJSON

        }
    }
    func populateTableData() {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

