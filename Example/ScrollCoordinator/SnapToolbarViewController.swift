//
//  SnapToolbarViewController.swift
//  ScrollCoordinator_Example
//

import UIKit
import ScrollCoordinator

class SnapToolbarViewController: UIViewController, ScrollCoordinatorManager {
    
    let cellIdentifier = "snapToolBarCell"
    var tableView: UITableView!
    var toolbar: UIToolbar!
    
    //Variable of ScrollCoordinatorManager protocol
    var scrollCoordinator: ScrollCoordinator?
    
    convenience init(needsScrollCoordinator: Bool) {
        self.init()
        self.automaticallyAdjustsScrollViewInsets = false
        if needsScrollCoordinator {
            scrollCoordinator = ScrollCoordinator()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        navigationItem.title = "SnapBehaviour(Nav+ToolBar)"
        navigationItem.backBarButtonItem?.title = "Back"
        

        toolbar = UIToolbar(frame: CGRect(x: 0, y: view.bounds.size.height - 44, width: view.bounds.width, height: 44))
        
        let premierLeagueView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        premierLeagueView.image = UIImage(named: "premierLeagueTitle")
        
        toolbar.addSubview(premierLeagueView)
        view.addSubview(toolbar)
        
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
        
        addBehaviour(view: toolbar, behaviour: SnapBehaviour(snapDirection: .BOTTOM, view: toolbar, refreshControl: nil, snapDelegate: nil))
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
