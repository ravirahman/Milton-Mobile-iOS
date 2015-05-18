import UIKit

class Home_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //configureToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var toolbar: UIToolbar!
    /*func configureToolbar() {
        let toolbarButtonItems = [
            //flexibleSpaceBarButtonItem,
           // toolbarSectionsItem,
            flexibleSpaceBarButtonItem,
            toolbarSettingsItem//,
            //flexibleSpaceBarButtonItem
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
    }*/
    
   /* var toolbarSectionsItem: UIBarButtonItem {
        let toolbarSectionsItem = UIBarButtonItem(title: "Sections", style: .Plain, target: self, action: "barButtonItemClicked:")
        return toolbarSectionsItem
    }*/
    

    var toolbarSettingsItem: UIBarButtonItem {
        let toolbarSettingsItem = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "barButtonItemClicked:")
        return toolbarSettingsItem
    }
    
    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        // Note that there's no target/action since this represents empty space.
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    }
    
    func barButtonItemClicked(barButtonItem: UIBarButtonItem) {
        if(barButtonItem.title == toolbarSettingsItem.title){
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Settings_ViewController") as! Settings_ViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }

    }

    @IBOutlet weak var navigationTableView: UITableView!
    
    let categories = [
        ("Events",["SAA"]),
        ("Food",["FLIK"]),
        ("Me",["Mailbox"])//,
        //("Campus",["Door Lock"])
    ]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var (sectionName,subsections) = categories[section]
        return subsections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var (sectionName,subsections) = categories[indexPath.section]
        cell.textLabel?.text = subsections[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var (sectionName,subsections) = categories[section]
        return sectionName
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var (sectionName,subsections) = categories[indexPath.section]
        var subsection = subsections[indexPath.row]
        switch (sectionName) {
            case "Food":
                switch(subsection) {
                    case "FLIK":
                        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Food_Flik_ViewController") as! Food_Flik_ViewController
                        
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        break
                    default:
                        break
                }
                break
        case "Events":
            switch(subsection) {
            case "SAA":
                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Events_Saa_ViewController") as! Events_Saa_ViewController
                
                self.navigationController?.pushViewController(secondViewController, animated: true)
                break
            default:
                break
            }
            break
        case "Me":
            switch(subsection) {
            case "Mailbox":
                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Me_Mailbox_ViewController") as! Me_Mailbox_ViewController
                
                self.navigationController?.pushViewController(secondViewController, animated: true)
                break
            default:
                break
            }
            break
        default:
            break
        /*case "Campus":
            switch(subsection) {
            case "Doorlock":
                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Campus_Doorlock_ViewController") as! Food_Flik_ViewController
                
                self.navigationController?.pushViewController(secondViewController, animated: true)
                break
            default:
                break
            }
            break
            default:
                break*/
            
        }
    }
}