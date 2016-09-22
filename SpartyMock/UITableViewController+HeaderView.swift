//
//  UITableViewController+HeaderView.swift
//  TableViewHeader
//
//  Created by David Colvin on 6/22/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    
    func heightForHeader(header:HeaderView) -> CGFloat {
        let labelHeight = header.messageLabel.frame.size.height
        return labelHeight + 16
    }
    
    func formatTableHeader(header: HeaderView, height: CGFloat) {
        
        self.tableView.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableView.tableHeaderView = header
    }
    
    func setupHeaderView() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        guard let headerView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)!.first as? HeaderView else {
            return
        }
        headerView.hidden = true
        self.tableView.tableHeaderView = headerView
        self.tableView.contentInset = UIEdgeInsets(top: -headerView.frame.size.height, left: 0, bottom: 0, right: 0)
    }
    
    func rotated() {
        
        guard let headerView = self.tableView.tableHeaderView as? HeaderView else {return}
        if headerView.hidden == false {
            let labelHeight = headerView.messageLabel.frame.size.height + 20
            formatTableHeader(headerView, height: labelHeight)
            hideHeaderView()
        }
    }
    
    func showHeaderView(message: String, textColor:UIColor = UIColor.whiteColor(), backgroundColor:UIColor = UIColor.redColor(), duration: Double = 0.2) {
        
        guard let headerView = self.tableView.tableHeaderView as? HeaderView else {return}
        
        if headerView.hidden == false {
            
            headerView.hidden = false
            headerView.backgroundColor = backgroundColor
            headerView.messageLabel.textColor = textColor
            headerView.messageLabel.text = message
            headerView.messageLabel.numberOfLines = 0
            headerView.messageLabel.sizeToFit()
            
            let labelHeight = headerView.messageLabel.frame.size.height + 20
            
            formatTableHeader(headerView, height: labelHeight)
            
            UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }, completion: nil)
        }
        
    }
    
    func hideHeaderView(duration: Double = 0.2) {
        
        guard let headerView = self.tableView.tableHeaderView as? HeaderView else {return}
        
        if headerView.hidden == false {
            UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.tableView.contentInset = UIEdgeInsets(top: -headerView.frame.size.height, left: 0, bottom: 0, right: 0)
                }, completion: { finished in
                    headerView.hidden = true
            })
            
        }
        
    }
}
