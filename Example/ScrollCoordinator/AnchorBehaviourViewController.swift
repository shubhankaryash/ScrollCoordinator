//
//  AnchorBehaviourViewController.swift
//  ScrollCoordinator_Example
//

import UIKit
import ScrollCoordinator

class AnchorBehaviourViewController: UIViewController, ScrollCoordinatorManager {
    //Variable of ScrollCoordinatorManager protocol
    var scrollCoordinator: ScrollCoordinator?
    
    let anchorCellIdentifier = "anchorCell"
    let anchorNestedScrollIdentifier = "nestedScrollCell"
    
    var tableView: UITableView!
    
    var isAnchorBehaviourEnabled = false
    
    convenience init(isAnchorBehaviourEnabled: Bool) {
        self.init()
        self.isAnchorBehaviourEnabled = isAnchorBehaviourEnabled
        self.automaticallyAdjustsScrollViewInsets = false
        initialiseCoordinatorIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "AnchorBehaviour"
        navigationItem.backBarButtonItem?.title = "Back"
        setupTableView()
        registerScrollViewToCoordinator(scrollView: tableView)
        tableViewDidLoad()
    }
    
    private func initialiseCoordinatorIfNeeded() {
        if isAnchorBehaviourEnabled {
            scrollCoordinator = ScrollCoordinator()
        }
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
