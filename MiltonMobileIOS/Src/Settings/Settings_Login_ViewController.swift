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
        
        Alamofire.request(.POST,"https://my.milton.edu/student/index.cfm").responseString{(_,_,data,_) in
            var nsdata = NSString(string: data!);
            var document = HTMLDocument(string: nsdata as String)
            var blc = document.firstNodeMatchingSelector(".bluelabel").textContent
            if (blc == nil) {
                //error
            }
            var lastName = blc.substringWithRange(Range<String.Index>(start: advance(blc.startIndex,blc.indexOfCharacter(">")!+9), end: advance(blc.startIndex, blc.indexOfCharacter(",")!)))
            var firstName = blc.substringWithRange(Range<String.Index>(start: advance(blc.startIndex,blc.indexOfCharacter(",")!+2), end: advance(blc.startIndex, blc.indexOfCharacter("[")!-1)))
            var classRoman = blc.substringWithRange(Range<String.Index>(start: advance(blc.startIndex,blc.indexOfCharacter("[")!+8), end: advance(blc.startIndex, blc.indexOfCharacter(":")!-1)))
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