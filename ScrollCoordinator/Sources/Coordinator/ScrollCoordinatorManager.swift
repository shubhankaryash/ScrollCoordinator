//
//  ScrollCoordinatorManager.swift
//  ScrollCoordinator
//

import Foundation


//Needs to be implemented by the ViewController/View which would govern the behaviours through the ScrollCoordinator
public protocol ScrollCoordinatorManager: class {
    
    //Instance of the ScrollCoordinator present in the manager. The manager needs to govern how and when this would be used
    var scrollCoordinator: ScrollCoordinator? { get set }
    /*
     Methods to be implemented by the ScrollCoordinatorManager
     */
    
    //This is the method through which the necessary views can get the ScrollCoordinator being used by the manager
    func getScrollCoordinator() -> ScrollCoordinator?
    
    //This should be the method to add the required behaviour associated with a view to the ScrollCoordinator
    func addBehaviour(view: UIView, behaviour: Behaviour)
    
    //This should be the method to remove the required behaviour associated with a view from the ScrollCoordinator
    func removeBehaviour(view: UIView)
    
    //This should be the method to get the behaviour associated with a view from the ScrollCoordinator
    func getBehaviour(for view: UIView) -> Behaviour?
    
    //This should be the method to register a scroll view to the ScrollCoordinator
    func registerScrollViewToCoordinator(scrollView: UIScrollView)
    
    //These methods should inform the ScrollCoordinator of the VC Level callbacks
    func informCoordinatorVCWillAppear()
    func informCoordinatorVCWillDisappear()
    func informCoordinatorVCDidSublayoutViews()
}
