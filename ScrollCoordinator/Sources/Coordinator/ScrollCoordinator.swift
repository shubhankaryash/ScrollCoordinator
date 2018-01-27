//
//  ScrollCoordinator.swift
//  ScrollCoordinator
//

import Foundation


public class ScrollCoordinator: NSObject, PanGestureHandlerDelegate {
    
    //Maintaining the list of helpers. These helpers are attached to the registered scrollViews and give scroll callbacks through pan gesture
    var listOfHandlers = [PanGestureHandler]()
    
    //Maintaining the map of behaviours each attached to a view. These behaviours need to be passed the scroll information and vc level callbacks
    var mapOfBehaviours = [UIView: Behaviour]()
    
    //Allows addition of custom behaviours to the coordinatorLayout. These behaviours will be receiving the scroll event and vc level callbacks
    public func addBehaviour(view: UIView, behaviour: Behaviour) {
        mapOfBehaviours[view] = behaviour
    }
    
    //Allows removal of custom behaviours already added to the coordinatorLayout
    public func removeBehaviour(view: UIView) {
        mapOfBehaviours.removeValue(forKey: view)
    }
    
    
    //Allows registration of a scrollView to the coordinatorLayout. This will make the coordinator layout listen to the scroll events in these and pass it along to all the behaviours
    public func registerScrollView(scrollView: UIScrollView) {
        let gestureHandler = PanGestureHandler(scrollView: scrollView)
        gestureHandler.gestureHandlerDelegate = self
        listOfHandlers.append(gestureHandler)
    }
    
    /*
     Listening to the gesture callbacks through the GestureHandlerDelegate protocol and passing the gesture information to the behaviours
     */
    func handleGesture(gestureInfo: PanGestureInformation, scrollTranslationInfo: ScrollTranslationInformation) {
        for behaviour in mapOfBehaviours.values {
            if let dependantScroll = behaviour.getDependantScrollView() {
                if dependantScroll == scrollTranslationInfo.scrollView {
                    //In case the behaviour defines a dependant scroll we only send it events from that dependant scroll
                    behaviour.handleGestureFromDependantScroll(gestureInfo: gestureInfo, scrollTranslationInfo: scrollTranslationInfo)
                }
            } else {
                //In case the behaviour does not define a dependant scroll we send it events from all scrolls
                behaviour.handleGestureFromDependantScroll(gestureInfo: gestureInfo, scrollTranslationInfo: scrollTranslationInfo)
            }
        }
    }
    
    func gestureDidStart(scrollView: UIScrollView) {
        for behaviour in mapOfBehaviours.values {
            if let dependantScroll = behaviour.getDependantScrollView() {
                if dependantScroll == scrollView {
                    //In case the behaviour defines a dependant scroll we only send it events from that dependant scroll
                    behaviour.gestureDidStart(scrollView: scrollView)
                }
            } else {
                //In case the behaviour does not define a dependant scroll we send it events from all scrolls
                behaviour.gestureDidStart(scrollView: scrollView)
            }
        }
    }
    
    func gestureDidFinish(gestureInfo: PanGestureInformation, scrollView: UIScrollView) {
        for behaviour in mapOfBehaviours.values {
            if let dependantScroll = behaviour.getDependantScrollView() {
                if dependantScroll == scrollView {
                    //In case the behaviour defines a dependant scroll we only send it events from that dependant scroll
                    behaviour.gestureDidFinish(gestureInfo: gestureInfo, scrollView: scrollView)
                }
            } else {
                //In case the behaviour does not define a dependant scroll we send it events from all scrolls
                behaviour.gestureDidFinish(gestureInfo: gestureInfo, scrollView: scrollView)
            }
        }
    }
    
    func scrollDidTranslateAfterGesture(scrollTranslationInfo: ScrollTranslationInformation) {
        for behaviour in mapOfBehaviours.values {
            if behaviour.needsPostGestureInfo {
                if let dependantScroll = behaviour.getDependantScrollView() {
                    if dependantScroll == scrollTranslationInfo.scrollView {
                        //In case the behaviour defines a dependant scroll we only send it events from that dependant scroll
                        behaviour.scrollDidTranslateAfterGesture(scrollTranslationInfo: scrollTranslationInfo)
                    }
                } else {
                    //In case the behaviour does not define a dependant scroll we send it events from all scrolls
                    behaviour.scrollDidTranslateAfterGesture(scrollTranslationInfo: scrollTranslationInfo)
                }
            }
        }
    }
    
    /*
     Listening to the vc level callbacks and passing the gesture information to the behaviours
     */
    public func vcWillAppear() {
        for behaviour in mapOfBehaviours.values {
            behaviour.vcWillAppear()
        }
    }
    
    public func vcWillDisappear() {
        for behaviour in mapOfBehaviours.values {
            behaviour.vcWillDisappear()
        }
    }
    
    public func vcDidSublayoutViews() {
        for behaviour in mapOfBehaviours.values {
            behaviour.vcDidSubLayoutViews()
        }
    }
}
