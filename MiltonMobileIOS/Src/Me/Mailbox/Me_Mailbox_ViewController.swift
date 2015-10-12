import UIKit
import Alamofire

class Me_Mailbox_ViewController: UIViewController {
    @IBOutlet weak var mailboxNumberField: UILabel!
    @IBOutlet weak var mailboxCombinationField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let _ = KeychainWrapper.stringForKey("loggedIn") {
            let username = KeychainWrapper.stringForKey("username")!
            let password = KeychainWrapper.stringForKey("password")!
            
            
            Alamofire.request(.GET,"http://backend.ma1geek.org/me/mailbox/get", parameters:["username":username,"password":password]).responseJSON{response in
                let data = response.2.value;
                var json = JSON(data!).dictionaryObject as! [String: String]
                let mailbox = json["mailbox"]
                let combination = json["combo"]
                
                self.mailboxNumberField.text = mailbox
                self.mailboxCombinationField.text = combination
            }
        }
        else {
            let alert = UIAlertView();
            alert.title = "Not Logged In"
            alert.message = "In order to see your mailbox combination, you must first log in"
            alert.addButtonWithTitle("OK")
            alert.show()
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
