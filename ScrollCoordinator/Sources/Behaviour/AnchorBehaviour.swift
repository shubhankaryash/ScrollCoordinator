//
//  AnchorBehaviour.swift
//  ScrollCoordinator
//

import Foundation

//Behaviour to scroll upto a certain point, after which the scroll would be "anchored" even as the views below it continue to scroll
public class AnchorBehaviour: Behaviour {
    public var needsPostGestureInfo: Bool = false
    
    private let shouldPreventOriginalScroll: Bool

    //The scrollView which needs to be anchored
    let scrollView: UIScrollView
    
    //The height at which the scrollView needs to be anchored
    let anchorHeight: CGFloat
    
    public init(scrollView: UIScrollView, anchorHeight: CGFloat, shouldPreventOriginalScroll: Bool) {
        self.scrollView = scrollView
        self.anchorHeight = anchorHeight
        self.shouldPreventOriginalScroll = shouldPreventOriginalScroll
    }
    
    public func vcWillAppear(){
        //Reset offset to starting position
        let newContentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(newContentOffset, animated: false)
    }
    
    public func vcWillDisappear() {
        //Nothing
    }
    
    public func vcDidSubLayoutViews(){
        //Nothing
    }
    
    public func handleGestureFromDependantScroll(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
        
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
    
    public func getDependantScrollView() -> UIScrollView? {
        return nil
    }
    
    public func gestureDidStart(scrollView: UIScrollView) {
        
    }
    
    
    public func gestureDidFinish(gestureInfo: PanGestureInformation, scrollView: UIScrollView) {
        
    }
    
    public func scrollDidTranslateAfterGesture(scrollTranslationInfo: ScrollTranslationInformation) {

    }
    
    func scrollingTowardsBottom(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
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
    
    func scrollingTowardsTop(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
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
