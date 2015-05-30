import UIKit
import Alamofire

class Me_Mailbox_ViewController: UIViewController {
    @IBOutlet weak var mailboxNumberField: UILabel!
    @IBOutlet weak var mailboxCombinationField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let responseString = KeychainWrapper.stringForKey("loggedIn") {
            let username = KeychainWrapper.stringForKey("username")!
            let password = KeychainWrapper.stringForKey("password")!
            
            
            Alamofire.request(.POST,"http://ma1geek.org/mailbox2.php", parameters:["username":username,"password":password]).responseJSON{(_,_,data,_) in
                var json = JSON(data!).dictionaryObject as! [String: String]
                var mailbox = json["mailbox"]
                var combination = json["combo"]
                
                self.mailboxNumberField.text = mailbox
                self.mailboxCombinationField.text = combination
            }
        }
        else {
            var alert = UIAlertView();
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
