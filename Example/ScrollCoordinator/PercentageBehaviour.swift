//
//  PercentageBehaviour.swift
//  ScrollCoordinator_Example
//

import ScrollCoordinator

class PercentageBehaviour: Behaviour {
    var needsPostGestureInfo: Bool = true

    //The scrollView through which the percentage needs to be calculated
    let scrollView: UIScrollView
    
    //The view through which the percentage shall be displayed
    let headerView: HeaderView
    
    public init(scrollView: UIScrollView, headerView: HeaderView) {
        self.scrollView = scrollView
        self.headerView = headerView
    }

    func handleGestureFromDependantScroll(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
        adjustPercentage()
    }
    
    func getDependantScrollView() -> UIScrollView? {
        return scrollView
    }
    
    func gestureDidStart(scrollView: UIScrollView) {
        //Nothing
    }
    
    func gestureDidFinish(gestureInfo: PanGestureInformation, scrollView: UIScrollView) {
        adjustPercentage()
    }
    
    public func scrollDidTranslateAfterGesture(scrollTranslationInfo: ScrollTranslationInformation) {
        adjustPercentage()
    }
        
    func vcWillAppear() {
        adjustPercentage()
    }
    
    func vcWillDisappear() {
        adjustPercentage()
    }
    
    func vcDidSubLayoutViews() {
        adjustPercentage()
    }
    
    func adjustPercentage() {
        let percentage: CGFloat = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.height)
        let newWidth = headerView.maxWidth * percentage
        let height = headerView.percentageView.frame.height
        headerView.percentageView.frame = CGRect(x: 0, y: 0, width: newWidth, height: height)
    }
    
    
}
