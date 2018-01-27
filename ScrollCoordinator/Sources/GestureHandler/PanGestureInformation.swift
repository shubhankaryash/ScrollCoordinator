//
//  PanGestureInformation.swift
//  ScrollCoordinator
//

import Foundation

public enum HorizontalGestureDirection: Int {
    case left
    case right
    case unknown
}

public enum VerticalGestureDirection: Int {
    case up
    case down
    case unknown
}


public class PanGestureInformation {
    
    public var gesture = UIPanGestureRecognizer()
    
    public var horizontalDirection: HorizontalGestureDirection = .unknown
    public var horizontalDelta: CGFloat = 0
    
    public var verticalDirection: VerticalGestureDirection = .unknown
    public var verticalDelta: CGFloat = 0
    
    public func setInfo(gesture: UIPanGestureRecognizer, lastGestureOffset: CGPoint, currentGestureOffset: CGPoint) {
        self.gesture = gesture
        
        if lastGestureOffset.y < currentGestureOffset.y {
            verticalDirection = .down
        } else {
            verticalDirection = .up
        }
        verticalDelta =  abs(lastGestureOffset.y - currentGestureOffset.y)
        
        if lastGestureOffset.x < currentGestureOffset.x {
            horizontalDirection = .right
        } else {
            horizontalDirection = .left
        }
        horizontalDelta =  abs(lastGestureOffset.x - currentGestureOffset.x)
    }
}
