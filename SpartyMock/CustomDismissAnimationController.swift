//
//  CustomDismissAnimationController.swift
//  SpartyMock
//
//  Created by David Colvin on 8/15/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class CustomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        
        toViewController.view.frame = finalFrameForVC
        
        if let snapshotView = fromViewController.view.snapshotViewAfterScreenUpdates(false) {
            
            snapshotView.frame = fromViewController.view.frame
            
            let containerView = transitionContext.containerView()
            containerView.addSubview(toViewController.view)
            containerView.sendSubviewToBack(toViewController.view)
            containerView.addSubview(snapshotView)
            
            
            var frame  = finalFrameForVC
            frame.origin.y -= UIScreen.mainScreen().bounds.size.height
            
            fromViewController.view.removeFromSuperview()
            
            UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 300, initialSpringVelocity: 5.0, options: .BeginFromCurrentState, animations: {
                snapshotView.frame = frame
                
                }, completion: {
                    finished in
                    snapshotView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
    }
    
}
