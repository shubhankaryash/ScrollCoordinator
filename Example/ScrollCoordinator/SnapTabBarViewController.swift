//
//  SnapTabBarViewController.swift
//  ScrollCoordinator_Example
//

import UIKit
import ScrollCoordinator

class SnapTabBarViewController: UIViewController, ScrollCoordinatorManager {
    
    let cellIdentifier = "snapTabBarCell"
    var tableView: UITableView!
    var toolbar: UIToolbar!
    public var tabIdentifier: String = ""
    
    //Variable of ScrollCoordinatorManager protocol
    var scrollCoordinator: ScrollCoordinator?
    
    convenience init(needsScrollCoordinator: Bool) {
        self.init()
        if needsScrollCoordinator {
            scrollCoordinator = ScrollCoordinator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        navigationItem.title = "SnapBehaviour(Nav+TabBar)"
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTouched))
        navigationItem.leftBarButtonItem = cancelButton
        
        if let tabBar = navigationController?.tabBarController?.tabBar {
            tabBar.barTintColor = UIColor(white: 230/255, alpha: 1)
        }
        
        performCoordinatorOperations()
    }
    
    func performCoordinatorOperations() {
        //Register the scroll view to send events
        registerScrollViewToCoordinator(scrollView: tableView)
        
        //Adding NavBarSnapBehaviour
        if (navigationController != nil || navigationController?.navigationBar != nil) {
            if let navController = navigationController {
                self.extendedLayoutIncludesOpaqueBars = true
                addBehaviour(view: navController.navigationBar, behaviour: NavbarSnapBehaviour(snapDirection: .TOP, navController: navController, scrollView: tableView, refreshControl: nil, snapDelegate: nil))
            }
        }
        
        if let bottomBar = navigationController?.tabBarController?.tabBar {
            addBehaviour(view: bottomBar, behaviour: SnapBehaviour(snapDirection: .BOTTOM, view: bottomBar, refreshControl: nil, snapDelegate: nil))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        informCoordinatorVCWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        informCoordinatorVCDidSublayoutViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        informCoordinatorVCWillDisappear()
    }
    
    @objc func cancelButtonTouched(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /*
     Methods of ScrollCoordinatorManager protocol
     */
    func getScrollCoordinator() -> ScrollCoordinator? {
        return scrollCoordinator
    }
    
    func addBehaviour(view: UIView, behaviour: Behaviour) {
        scrollCoordinator?.addBehaviour(view: view, behaviour: behaviour)
    }
    
    func removeBehaviour(view: UIView) {
        scrollCoordinator?.removeBehaviour(view: view)
    }
    
    func getBehaviour(for view: UIView) -> Behaviour? {
        return scrollCoordinator?.getBehaviour(for: view)
    }
    
    func registerScrollViewToCoordinator(scrollView: UIScrollView) {
        scrollCoordinator?.registerScrollView(scrollView: scrollView)
    }
    
    func informCoordinatorVCWillAppear() {
        scrollCoordinator?.vcWillAppear()
    }
    
    func informCoordinatorVCWillDisappear() {
        scrollCoordinator?.vcWillDisappear()
    }
    
    func informCoordinatorVCDidSublayoutViews() {
        scrollCoordinator?.vcDidSublayoutViews()
    }
}
