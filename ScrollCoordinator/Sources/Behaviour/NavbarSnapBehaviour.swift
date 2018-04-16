//
//  NavbarSnapBehaviour.swift
//  ScrollCoordinator
//

import Foundation

open class NavbarSnapBehaviour: SnapBehaviour {
    
    //The underlying scrollView which contains the navigation bar
    public var scrollView: UIScrollView
    
    public init(snapDirection: SnapDirection, navController: UINavigationController, scrollView: UIScrollView, refreshControl: UIRefreshControl?, snapDelegate: SnapDelegate?) {
        self.scrollView = scrollView
        super.init(snapDirection: snapDirection, view: navController.navigationBar, isFadeEnabled: true, refreshControl: refreshControl, snapDelegate: snapDelegate)
        
        //Add listener for app coming to foreground
        NotificationCenter.default.addObserver(self, selector: #selector(NavbarSnapBehaviour.applicationWillEnterForeground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc open func applicationWillEnterForeground() {
        if currentSnapState != .EXPANDED {
            snapExpand()
            applyAlpha()
        }
    }
    
    override open func vcDidSubLayoutViews() {
        updateContentInsets()
    }
    
    override open func incrementalExpand(deltaOffset: CGFloat) {
        super.incrementalExpand(deltaOffset: deltaOffset)
        updateContentInsets()
    }
    
    override open func snapExpand() {
        super.snapExpand()
        updateContentInsets()
    }
    
    override open func incrementalContract(deltaOffset: CGFloat) {
        super.incrementalContract(deltaOffset: deltaOffset)
        updateContentInsets()
    }
    
    override open func snapContract() {
        super.snapContract()
        updateContentInsets()
    }
    
    
    //Update the insets of the scrollView. This ensures the scrollView takes up the space left when we snap the navigation bar
    fileprivate func updateContentInsets() {
        // if refreshing no need to update insets as it clashes with the UIRefresherControl
        if let isRefreshing = refreshControl?.isRefreshing, isRefreshing {
            return
        }
        
        let top = adjustTopInset(view.frame.origin.y + view.frame.height)
        
        scrollView.contentInset.top = top
        scrollView.scrollIndicatorInsets.top = top
    }
    
    //Need these due to iOS 11 compatibility issues
    fileprivate func adjustTopInset(_ top: CGFloat) -> CGFloat {
        if #available(iOS 11.0, *) {
            return top - scrollView.safeAreaInsets.top  // subtract safeAreaInsets for ios11
        }
        return top
    }
}
