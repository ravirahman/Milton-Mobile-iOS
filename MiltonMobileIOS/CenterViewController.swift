import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class CenterViewController: UIViewController, SidePanelViewControllerDelegate {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var creatorLabel: UILabel!
    
    var delegate: CenterViewControllerDelegate?

    // MARK: Button actions
    
    @IBAction func kittiesTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    @IBAction func puppiesTapped(sender: AnyObject) {
    }
    
    func categorySelected(navigationCategory: NavigationCategory) {
        imageView.image = navigationCategory.image
        titleLabel.text = navigationCategory.title
        creatorLabel.text = navigationCategory.creator
        
        delegate?.collapseSidePanels?()
    }
}