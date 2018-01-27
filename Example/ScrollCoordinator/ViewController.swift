//
//  ViewController.swift
//  ScrollCoordinator
//

import UIKit
import ScrollCoordinator

class ViewController: UITableViewController {
    
    // Data model: These strings will be the data for the table view cells
    let tabs = ["SnapBehaviour(Nav+ToolBar)", "SnapBehaviour(Nav+TabBar)" ,"NestedScroll without AnchorBehaviour", "NestedScroll with AnchorBehaviour", "CustomBehaviour"]

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "viewControllerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        if let navController = navigationController {
            setupNavigationController(navigationController: navController)
            navigationItem.title = "Scroll Coordinator"
        }
        // Register the table view cell class and its reuse id
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 100
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = 70
    }
    
    func setupNavigationController(navigationController: UINavigationController){
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barTintColor = UIColor(red: 41/255, green: 141/255, blue: 250/255, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tabs.count
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell? {
            // set the text from the data model
            cell.textLabel?.text = self.tabs[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        switch indexPath.row {
        case 0:
            let snapToolBarController = SnapToolbarViewController(needsScrollCoordinator: true)
            navigationController?.pushViewController(snapToolBarController, animated: true)
        case 1:
            let firstController = SnapTabBarViewController(needsScrollCoordinator: true)
            firstController.tabIdentifier = "TopRated"
            let firstNavController = UINavigationController(rootViewController: firstController)
            firstNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
            setupNavigationController(navigationController: firstNavController)
            
            let secondController = SnapTabBarViewController(needsScrollCoordinator: true)
            secondController.tabIdentifier = "Downloads"
            let secondNavController = UINavigationController(rootViewController: secondController)
            secondNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
            setupNavigationController(navigationController: secondNavController)
            
            let tabBarController = UITabBarController()
            tabBarController.automaticallyAdjustsScrollViewInsets = false
            tabBarController.viewControllers = [firstNavController, secondNavController]
            navigationController?.present(tabBarController, animated: true, completion: nil)
        case 2:
            let anchorViewController = AnchorBehaviourViewController(isAnchorBehaviourEnabled: false)
            navigationController?.pushViewController(anchorViewController, animated: true)
        case 3:
            let anchorViewController = AnchorBehaviourViewController(isAnchorBehaviourEnabled: true)
            navigationController?.pushViewController(anchorViewController, animated: true)
        default:
            let customViewController = CustomBehaviourViewController(needsScrollCoordinator: true)
            navigationController?.pushViewController(customViewController, animated: true)
        }

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        let labelText = "List Of Behaviours"
        let textAttributes = [NSAttributedStringKey.font: UIFont(name: "Palatino-Roman", size: 28), NSAttributedStringKey.foregroundColor: UIColor.black]
        headerView.attributedText = NSAttributedString(string: labelText, attributes: textAttributes)
        return headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

