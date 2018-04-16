//
//  CustomBehaviourViewController.swift
//  ScrollCoordinator_Example
//

import UIKit
import ScrollCoordinator

class CustomBehaviourViewController: UIViewController, ScrollCoordinatorManager {
    //Variable of ScrollCoordinatorManager protocol
    var scrollCoordinator: ScrollCoordinator?
    
    let customBehaviourCellIdentifier = "customBehaviourCell"    
    var tableView: UITableView!
    
    convenience init(needsScrollCoordinator: Bool) {
        self.init()
        if needsScrollCoordinator {
            scrollCoordinator = ScrollCoordinator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerScrollViewToCoordinator(scrollView: tableView)
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
