//
//  PanGestureHandlerDelegate.swift
//  ScrollCoordinator
//

import Foundation

protocol PanGestureHandlerDelegate: class {
    func handleGesture(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation)
    func gestureDidStart(scrollView: UIScrollView)
    func gestureDidFinish(gestureInfo: PanGestureInformation, scrollView: UIScrollView)
    func scrollDidTranslateAfterGesture(scrollTranslationInfo: ScrollTranslationInformation)
}
