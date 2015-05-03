import UIKit

protocol SidePanelViewControllerDelegate {
  func categorySelected(navigationCategory: NavigationCategory)
}

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SidePanelViewControllerDelegate?
        
    var navigationCategories: Array<NavigationCategory>!
    
    struct TableView {
        struct CellIdentifiers {
            static let NavigationCell = "NavigationCell"
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.NavigationCell, forIndexPath: indexPath) as! NavigationCell
        cell.configureforCateogry(navigationCategories[indexPath.row])
        return cell
    }
    
    // Mark: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCategory = navigationCategories[indexPath.row]
        delegate?.categorySelected(selectedCategory)
    }
    
}

class NavigationCell: UITableViewCell {
  @IBOutlet weak var animalImageView: UIImageView!
  @IBOutlet weak var imageNameLabel: UILabel!
  @IBOutlet weak var imageCreatorLabel: UILabel!
  
  func configureforCateogry(navigationCategory: NavigationCategory) {
    animalImageView.image = navigationCategory.image
    imageNameLabel.text = navigationCategory.title
    imageCreatorLabel.text = navigationCategory.creator
  }
}