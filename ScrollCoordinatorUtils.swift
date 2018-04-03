//
//  ScrollCoordinatorUtils.swift
//  ScrollCoordinator
//

import Foundation

public class ScrollCoordinatorUtils {
    
    // Method to get the height of the status bar
    static public func getStatusBarHeight() -> CGFloat {
        if UIApplication.shared.isStatusBarHidden {
            return 0
        }
        
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = min(statusBarSize.width, statusBarSize.height)
        return statusBarHeight
    }
}
