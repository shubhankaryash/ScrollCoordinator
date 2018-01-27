//
//  Behaviour.swift
//  ScrollCoordinator
//

import Foundation

public protocol Behaviour {
    var needsPostGestureInfo: Bool { get set }
    func handleGestureFromDependantScroll(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation)
    func getDependantScrollView() -> UIScrollView?
    func gestureDidStart(scrollView: UIScrollView)
    func gestureDidFinish(gestureInfo: PanGestureInformation, scrollView: UIScrollView)
    func scrollDidTranslateAfterGesture(scrollTranslationInfo: ScrollTranslationInformation)
    func vcWillAppear()
    func vcWillDisappear()
    func vcDidSubLayoutViews()
}
