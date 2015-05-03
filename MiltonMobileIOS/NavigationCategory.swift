import UIKit

class NavigationCategory {
    
    let title: String
    let creator: String
    let image: UIImage?
 
    init(title: String, creator: String, image: UIImage?) {
        self.title = title
        self.creator = creator
        self.image = image
    }
    
    class func allCategories() -> Array<NavigationCategory> {
        return [ NavigationCategory(title: "FLIK", creator: "", image: UIImage(named: "1329_logo.jpg")),
                 NavigationCategory(title: "SAA", creator: "", image: UIImage(named: "1329_logo.jpg")),
                 NavigationCategory(title: "Mailbox", creator: "", image: UIImage(named: "1329_logo.jpg")),
                 NavigationCategory(title: "Settings", creator: "", image: UIImage(named: "1329_logo.jpg"))]
    }
}