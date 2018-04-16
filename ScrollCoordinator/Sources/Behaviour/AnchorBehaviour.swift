//
//  AnchorBehaviour.swift
//  ScrollCoordinator
//

import Foundation

//Behaviour to scroll upto a certain point, after which the scroll would be "anchored" even as the views below it continue to scroll
open class AnchorBehaviour: Behaviour {
    public var needsPostGestureInfo: Bool = false
    public let shouldPreventOriginalScroll: Bool

    //The scrollView which needs to be anchored
    public let scrollView: UIScrollView
    
    //The height at which the scrollView needs to be anchored
    public let anchorHeight: CGFloat
    
    public init(scrollView: UIScrollView, anchorHeight: CGFloat, shouldPreventOriginalScroll: Bool) {
        self.scrollView = scrollView
        self.anchorHeight = anchorHeight
        self.shouldPreventOriginalScroll = shouldPreventOriginalScroll
    }
    
    open func vcWillAppear(){
        //Reset offset to starting position
        let newContentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(newContentOffset, animated: false)
    }
    
    open func vcWillDisappear() {
        //Nothing
    }
    
    open func vcDidSubLayoutViews(){
        //Nothing
    }
    
    open func handleGestureFromDependantScroll(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
        
        if gestureInfo.verticalDelta == 0 {
            return
        }
        
        if(gestureInfo.verticalDirection == .down) {
            scrollingTowardsBottom(gestureInfo: gestureInfo, scrollTranslationInfo: scrollTranslationInfo)
        }
        else {
            scrollingTowardsTop(gestureInfo: gestureInfo, scrollTranslationInfo: scrollTranslationInfo)
        }
    }
    
    open func getDependantScrollView() -> UIScrollView? {
        return nil
    }
    
    open func gestureDidStart(scrollView: UIScrollView) {
    }
    
    open func gestureDidFinish(gestureInfo: PanGestureInformation, scrollView: UIScrollView) {
    }
    
    open func scrollDidTranslateAfterGesture(scrollTranslationInfo: ScrollTranslationInformation) {
    }
    
    open func scrollingTowardsBottom(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
        let scrollViewOffset = scrollView.contentOffset
        let deltaOffset = gestureInfo.verticalDelta
        if  (scrollViewOffset.y > 0) {
            if shouldPreventOriginalScroll {
                scrollTranslationInfo.scrollView.contentOffset.y += scrollTranslationInfo.verticalDelta
            }
            let newContentOffset = CGPoint(x: scrollViewOffset.x, y: max(0,min(anchorHeight, scrollViewOffset.y - deltaOffset)))
            scrollView.setContentOffset(newContentOffset, animated: false)
        }
    }
    
    open func scrollingTowardsTop(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
        let scrollViewOffset = scrollView.contentOffset
        let deltaOffset = gestureInfo.verticalDelta
        if  (scrollViewOffset.y < anchorHeight) {
            if shouldPreventOriginalScroll {
                scrollTranslationInfo.scrollView.contentOffset.y -= scrollTranslationInfo.verticalDelta
            }
            let newContentOffset:CGPoint = CGPoint(x: scrollViewOffset.x, y: min(anchorHeight, scrollViewOffset.y + deltaOffset))
            scrollView.setContentOffset(newContentOffset, animated: false)
        }
        
    }
}
