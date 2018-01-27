//
//  ScrollTranslationInformation.swift
//  ScrollCoordinator
//

import Foundation

public class ScrollTranslationInformation {
    
    public var scrollView = UIScrollView()
    
    public var horizontalDirection: HorizontalGestureDirection = .unknown
    public var horizontalDelta: CGFloat = 0
    
    public var verticalDirection: VerticalGestureDirection = .unknown
    public var verticalDelta: CGFloat = 0
    
    public func setInfo(scrollView: UIScrollView, lastContentOffset: CGPoint, currentContentOffset: CGPoint) {
        self.scrollView = scrollView
        
        if lastContentOffset.y < currentContentOffset.y {
            verticalDirection = .down
        } else {
            verticalDirection = .up
        }
        verticalDelta =  abs(lastContentOffset.y - currentContentOffset.y)
        
        if lastContentOffset.x < currentContentOffset.x {
            horizontalDirection = .right
        } else {
            horizontalDirection = .left
        }
        horizontalDelta =  abs(lastContentOffset.x - currentContentOffset.x)
    }
}
