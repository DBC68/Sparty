//
//  PhotoVC.swift
//  PetAlert
//
//  Created by David Colvin on 7/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

protocol PhotoViewerDelegate {
    
    func deletePhoto()
    func replacePhoto()
}

class PhotoVC: UIViewController {

    //MARK: - Properties
    //--------------------------------------------------------------------------
    var photo: UIImage!
    var delegate:PhotoViewerDelegate! = nil
    
    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoView.image = photo
        
        self.toolbar.tintColor = UIColor.lightGrayColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI
    //--------------------------------------------------------------------------
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func closeAction(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func replaceAction(sender: AnyObject) {
        
        dismissViewControllerAnimated(true) {
            if self.delegate != nil {
                self.delegate.replacePhoto()
            }
        }
    }
    @IBAction func trashAction(sender: AnyObject) {
        
        dismissViewControllerAnimated(true) {
            
            if self.delegate != nil {
                self.delegate.deletePhoto()
            }
        }
    }
    
}
