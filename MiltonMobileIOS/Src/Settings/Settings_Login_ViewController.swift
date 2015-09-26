import UIKit
import Alamofire
import HTMLReader

protocol Home_ViewController_Delegate {
    func setLoggedIn()
}

class Settings_Login_ViewController: UIViewController, UITextFieldDelegate {
    var delegate: Home_ViewController_Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        
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
        validateCredentials()
    }
    
    func validateCredentials() {
        let accessType = accessTypeControler.titleForSegmentAtIndex(accessTypeControler.selectedSegmentIndex)
        let username = usernameField.text!
        let password = passwordField.text!;
        if (accessType == "Teacher" || accessType == "Parent") {
            let alert = UIAlertView();
            alert.title = "Not Supported"
            alert.message = accessType! + " login not yet supported"
            alert.addButtonWithTitle("Dismiss")
            alert.show()
        }
        else {
            self.usernameField.resignFirstResponder()
            self.passwordField.resignFirstResponder()
            
        }
        Alamofire.request(.POST,"http://my.milton.edu/student/index.cfm", parameters: ["UserLogin": username, "UserPassword": password]).responseString{response in
            let data = response.2.value!
            let nsdata = NSString(string: data);
            let document = HTMLDocument(string: nsdata as String)
            if data.lowercaseString.rangeOfString("bluelabel") != nil {
                var blc = document.firstNodeMatchingSelector(".bluelabel")!.textContent;
                blc = blc.stringByReplacingOccurrencesOfString("::", withString: "@").stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString("\t", withString: "").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ").stringByReplacingOccurrencesOfString("  ", withString: " ")
                
                let lastNameStart = blc.startIndex.advancedBy(blc.indexOfCharacter("s")!+9);
                let lastNameEnd = blc.startIndex.advancedBy(blc.indexOfCharacter(",")!);
                let lastName = blc.substringWithRange(Range<String.Index>(start: lastNameStart, end: lastNameEnd))
                
                
                
                let firstNameStart = blc.startIndex.advancedBy(blc.indexOfCharacter(",")!+2);
                let firstNameEnd = blc.startIndex.advancedBy(blc.indexOfCharacter("[")!-1);
                let firstName = blc.substringWithRange(Range<String.Index>(start: firstNameStart, end: firstNameEnd))
                
                let classRoman = blc.substringWithRange(Range<String.Index>(start: blc.startIndex.advancedBy(blc.indexOfCharacter("[")!+8), end: blc.startIndex.advancedBy(blc.indexOfCharacter("@")!-1)))
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
                print("username: " + username);
                print("firstName: " + firstName);
                print("lastName: " + lastName);
                print("class: " + String(classNumber));
                
                KeychainWrapper.setString("true", forKey: "loggedIn")
                KeychainWrapper.setString(username, forKey: "username")
                KeychainWrapper.setString(password, forKey: "password")
                KeychainWrapper.setString(firstName, forKey: "firstName")
                KeychainWrapper.setString(lastName, forKey: "lastName")
                KeychainWrapper.setString(String(classNumber), forKey: "classNumber")
                
                let alert = UIAlertView();
                alert.title = "Welcome"
                alert.message = "Welcome " + firstName + " " + lastName
                alert.addButtonWithTitle("Continue")
                alert.show()
                self.delegate?.setLoggedIn()
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                let alert = UIAlertView();
                alert.title = "Check your username and password"
                alert.message = "These credentials could not be validated"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
            
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        validateCredentials()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    

    
}
extension String
{
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = self.characters.indexOf(char) {
            return self.startIndex.distanceTo(idx)
        }
        return nil
    }
}