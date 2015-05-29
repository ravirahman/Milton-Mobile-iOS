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
    
    @IBOutlet weak var accessTypeControler: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginClicked(sender: AnyObject) {
        var accessType = accessTypeControler.titleForSegmentAtIndex(accessTypeControler.selectedSegmentIndex)
        var username = usernameField.text
        var password = passwordField.text;
        if (accessType == "Teacher" || accessType == "Parent") {
            var alert = UIAlertView();
            alert.title = "Not Supported"
            alert.message = accessType! + " login not yet supported"
            alert.addButtonWithTitle("Dismiss")
            alert.show()
        }
        else {
            validateCredentials(username, password: password)
        }
    }
    func validateCredentials(username: String, password: String) {
        
        Alamofire.request(.POST,"https://my.milton.edu/student/index.cfm", parameters: ["UserLogin": username, "UserPassword": password]).responseString{(_,_,data,_) in
            var nsdata = NSString(string: data!);
            var document = HTMLDocument(string: nsdata as String)
            if data?.lowercaseString.rangeOfString("bluelabel") != nil {
                var blc = document.firstNodeMatchingSelector(".bluelabel").textContent;
                blc = blc.stringByReplacingOccurrencesOfString("::", withString: "@").stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString("\t", withString: "").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ")
                
                var lastNameStart = advance(blc.startIndex,blc.indexOfCharacter("s")!+9)
                var lastNameEnd = advance(blc.startIndex, blc.indexOfCharacter(",")!)
                var lastName = blc.substringWithRange(Range<String.Index>(start: lastNameStart, end: lastNameEnd))
                
                
                
                var firstNameStart = advance(blc.startIndex,blc.indexOfCharacter(",")!+2)
                var firstNameEnd = advance(blc.startIndex, blc.indexOfCharacter("[")!-1)
                var firstName = blc.substringWithRange(Range<String.Index>(start: firstNameStart, end: firstNameEnd))
                
                var classRoman = blc.substringWithRange(Range<String.Index>(start: advance(blc.startIndex,blc.indexOfCharacter("[")!+8), end: advance(blc.startIndex, blc.indexOfCharacter("@")!-1)))
                var classNumber = 0;
                if (classRoman == "IV") {
                    classNumber = 4;
                }
                if (classRoman == "III") {
                    classNumber = 3;
                }
                
                if (classRoman == "II") {
                    classNumber = 2;
                }
                if (classRoman == "I") {
                    classNumber = 1;
                }
                println("username: " + username);
                println("firstName: " + firstName);
                println("lastName: " + lastName);
                println("class: " + String(classNumber));
                
                KeychainWrapper.setString(username, forKey: "username")
                KeychainWrapper.setString(password, forKey: "password")
                KeychainWrapper.setString(firstName, forKey: "firstName")
                KeychainWrapper.setString(lastName, forKey: "lastNAme")
                KeychainWrapper.setString(String(classNumber), forKey: "classNumber")
                var alert = UIAlertView();
                alert.title = "Welcome"
                alert.message = "Welcome " + firstName + " " + lastName
                alert.addButtonWithTitle("Continue")
                alert.show()
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                var alert = UIAlertView();
                alert.title = "Check your username and password"
                alert.message = "These credentials could not be validated"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
            
        }
    }

    
}
extension String
{
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = find(self, char) {
            return distance(self.startIndex, idx)
        }
        return nil
    }
}