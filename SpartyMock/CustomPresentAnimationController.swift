//
//  CustomPresentAnimationController.swift
//  SpartyMock
//
//  Created by David Colvin on 8/15/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        let containerView = transitionContext.containerView()
        let bounds = UIScreen.mainScreen().bounds
        toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, -bounds.size.height)
        containerView?.addSubview(toViewController.view)
        
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 300, initialSpringVelocity: 5.0, options: .BeginFromCurrentState, animations: {
            toViewController.view.frame = finalFrameForVC
        }) { (finished) in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        }
    }
    
}