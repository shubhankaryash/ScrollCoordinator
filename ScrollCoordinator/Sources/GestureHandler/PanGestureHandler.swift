//
//  PanGestureHandler.swift
//  ScrollCoordinator
//

import Foundation
import UIKit

class PanGestureHandler: NSObject, UIGestureRecognizerDelegate {
    
    // ScrollView on which PanGestureRecognizer is attached.
    private let scrollView: UIScrollView
    weak var gestureHandlerDelegate: PanGestureHandlerDelegate?
    private var lastScrollOffset = CGPoint()
    private var lastGestureOffset = CGPoint()
    private var panGestureInfo = PanGestureInformation()
    private var scrollTranslationInfo = ScrollTranslationInformation()
    private var currentlyObserving = false
    private var myContext = 0

    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init()
        self.attachGesture(scrollView: scrollView)
    }
    
    private func attachGesture(scrollView: UIScrollView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(PanGestureHandler.handlePanGesture(_:)))
        panGesture.delegate = self
        scrollView.addGestureRecognizer(panGesture)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        lastGestureOffset.x = 0
        lastGestureOffset.y = 0
        return true
    }
    
    
    //Propogate the gesture to the GestureHandler delegate
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let currentGestureOffset = gesture.translation(in: scrollView)
        panGestureInfo.setInfo(gesture: gesture, lastGestureOffset: lastGestureOffset, currentGestureOffset: currentGestureOffset)
        scrollTranslationInfo.setInfo(scrollView: scrollView, lastContentOffset: lastScrollOffset, currentContentOffset: scrollView.contentOffset)
        switch gesture.state {
        case .began:
            if currentlyObserving {
                scrollView.removeObserver(self, forKeyPath: "contentOffset")
                currentlyObserving = false
            }
            gestureHandlerDelegate?.gestureDidStart(scrollView: scrollView)
        case .ended:
            gestureHandlerDelegate?.gestureDidFinish(gestureInfo: panGestureInfo, scrollView: scrollView)
            if !currentlyObserving {
                scrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: &myContext)
                currentlyObserving = true
            }
        default:
            gestureHandlerDelegate?.handleGesture(gestureInfo: panGestureInfo, scrollTranslationInfo: scrollTranslationInfo)
        }
        lastScrollOffset = scrollView.contentOffset
        lastGestureOffset = currentGestureOffset
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext {
            if let oldOffset = change?[.oldKey] as? CGPoint, let newOffset = change?[.newKey] as? CGPoint {
                scrollTranslationInfo.setInfo(scrollView: scrollView, lastContentOffset: oldOffset, currentContentOffset: newOffset)
                gestureHandlerDelegate?.scrollDidTranslateAfterGesture(scrollTranslationInfo: scrollTranslationInfo)
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        if currentlyObserving {
            scrollView.removeObserver(self, forKeyPath: "contentOffset")
            currentlyObserving = false
        }
    }
    
}



