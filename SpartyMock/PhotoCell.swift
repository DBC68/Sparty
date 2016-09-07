//
//  PhotoCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoViewerDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var cameraView: UIImageView!
    
    var controller:UIViewController!
    
    var cellDescriptor: CellDescriptor! {
        didSet {
            self.cameraView.tintColor = UIColor.lightGrayColor()
//            self.photoView.layer.cornerRadius = Constants.ImageBorderRadius
            self.photoView.layer.borderColor = UIColor.imageBorderColor().CGColor
//            self.photoView.layer.borderWidth = Constants.ImageBorderWidth
        }
    }
    
    //MARK - Photo
    //--------------------------------------------------------------------------
    
    @IBAction func photoAction(sender: AnyObject) {
        
        if (cellDescriptor.value as? UIImage) != nil {
            showImage()
//            showImageOptionsAlert()
        } else {
            showImagePicker()
        }
    }
    
    func showImagePicker() {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        self.controller.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    private func showImage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = storyboard.instantiateViewControllerWithIdentifier("PhotoVC") as! PhotoVC
        photoVC.photo = self.cellDescriptor.value as? UIImage
        photoVC.delegate = self
        self.controller.presentViewController(photoVC, animated: true, completion: nil)
    }
    
    func replacePhoto() {
        self.showImagePicker()
    }
    
    func deletePhoto() {
        self.removePhoto()
    }
    
    /*
    private func showImageOptionsAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.view.tintColor = UIColor.alertTextColor()
        
        alertController.addAction(UIAlertAction(title: "Change Image", style: .Default, handler: { (action) in
            self.showImagePicker()
        }))
        
        alertController.addAction(UIAlertAction(title: "View Image", style: .Default, handler: { (action) in
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let photoVC = storyboard.instantiateViewControllerWithIdentifier("PhotoVC") as! PhotoVC
            photoVC.photo = self.cellDescriptor.value as? UIImage
            self.controller.presentViewController(photoVC, animated: true, completion: nil)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Remove Image", style: .Destructive, handler: { (action) in
            self.removeImage()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:nil))
        self.controller.presentViewController(alertController, animated: true, completion: nil)
    }
 */
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.cellDescriptor.value = image
            showPhoto(image)
        }
        
        self.controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showPhoto(image: UIImage) {
        self.photoView.image = image
        self.photoView.hidden = false
        self.cameraView.hidden = true
        self.cellDescriptor.value = image
    }
    
    func removePhoto() {
        self.photoView.image = nil
        self.photoView.hidden = true
        self.cameraView.hidden = false
        self.cellDescriptor.value = nil
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
