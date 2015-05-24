import UIKit
import Alamofire
import HTMLReader

class Settings_Login_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateCredentials(username: String, password: String) {
        let url = NSURL(string: "https://my.milton.edu/student/index.cfm") //TODO fix the date so the user can select it
        var request : NSMutableURLRequest = NSMutableURLRequest()
        
        Alamofire.request(.POST,"https://my.milton.edu/student/index.cfm",parameters: ["":""]).response{(request, response, data, error) in

            
            }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
