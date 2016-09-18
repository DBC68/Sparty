//
//  RegisterTVC.swift
//  Sparty
//
//  Created by David Colvin on 9/10/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase

class RegisterTVC: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoViewerDelegate {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var vm: RegisterVM!

    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var screenNameField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var mottoField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var cameraView: UIImageView!
    
    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.lightNavBar()
        screenNameField.becomeFirstResponder()
        vm = RegisterVM(controller: self)
        doneButton.enabled = false
        
        cameraView.tintColor = UIColor.lightGrayColor()
        photoView.layer.cornerRadius = photoView.frame.size.width / 2
        photoView.layer.borderColor = UIColor.imageBorderColor().CGColor
        photoView.layer.borderWidth = Constants.ImageBorderWidth
        removePhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func textChanged(sender: UITextField) {
        doneButton.enabled = vm.isValid
    }
    @IBAction func doneAction(sender: AnyObject) {
        
        view.endEditing(true)

        vm.photo = photoView.image
        
        guard vm.isValid == true else {
            showHeaderView("Invalid Entry")
            return
        }
        
        FirbaseManager.isUniqueScreenName(vm.username) {
            
            result in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if result == true {
                    
                    let user = self.vm.createUser()
                    
                    FirbaseManager.saveUsername(user.displayName)
                    
                    FirbaseManager.saveUserInfo(user.dict())
                    
                    NSUserDefaults.setIsRegistered(true)
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.showMessagePrompt("The screenName \(self.vm.username) is already taken.  Please try again.")
                }
            })
        }
    }
   
    @IBAction func addPhotoAction(sender: AnyObject) {
        
        view.endEditing(true)
        
        if vm.photo != nil {
            showImage()
        } else {
            showImagePicker()
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        view.endEditing(true)
        
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
            do {
                try! FIRAuth.auth()!.signOut()
                
                GIDSignIn.sharedInstance().signOut()
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: .Cancel, handler:nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Photo
    //--------------------------------------------------------------------------
    func showImagePicker() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    private func showImage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = storyboard.instantiateViewControllerWithIdentifier("PhotoVC") as! PhotoVC
        photoVC.photo = vm.photo
        photoVC.delegate = self
        presentViewController(photoVC, animated: true, completion: nil)
    }
    
    func replacePhoto() {
        showImagePicker()
    }
    
    func deletePhoto() {
        removePhoto()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            vm.photo = image
            showPhoto(image)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showPhoto(image: UIImage) {
        photoView.image = image
        photoView.hidden = false
        cameraView.hidden = true
        vm.photo = image
    }
    
    func removePhoto() {
        photoView.image = nil
        photoView.hidden = true
        cameraView.hidden = false
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    //MARK: - Text Field Delegate
    //--------------------------------------------------------------------------
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == screenNameField {
            //Check to see if unique
            if vm.isValidUsername {
                FirbaseManager.isUniqueScreenName(vm.username, completion: { (result) in
                    self.vm.isUniqueScreenName = result
                    print(self.vm.username + " is unique: \(result)")
                })
            }
        }
    }
    
}
