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
    
    // Calculates and returns angle of the gesture from the horizontal axis
    public func gestureAngle() -> CGFloat {
        return atan(self.verticalDelta/self.horizontalDelta)
    }
    
    // Calculates and returns angle of the gesture from the horizontal axis. If this angle is greater than the angleThreshhold, the gesture is deemed to be a vertical gesture
    public func isGestureVertical(with angleThreshhold: CGFloat = CGFloat.pi/6) -> Bool {
        if gestureAngle() > angleThreshhold {
            return true
        } else {
            return false
        }
    }
    
    // Calculates and returns angle of the gesture from the horizontal axis. If this angle is less than or equal to the angleThreshhold, the gesture is deemed to be a horizontal gesture
    public func isGestureHorizontal(with angleThreshhold: CGFloat = CGFloat.pi/6) -> Bool {
        if gestureAngle() <= angleThreshhold {
            return true
        } else {
            return false
        }
    }
}
