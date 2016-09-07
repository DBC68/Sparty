//
//  NewSpartyTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/28/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

protocol NewSpartyDelegate: class {
    func newSpartyCreated()
}

class NewSpartyTVC: UITableViewController, UITextViewDelegate {
    
    enum Row: Int {
        case Title
        case Description
        case Date
        case DatePicker
        case Duration
        case DurationPicker
        case Guests
        case Location
        case Photo
        
        static func allRows() -> [Row] {
            return [.Title, .Description, .Date, .DatePicker, .Duration, .DurationPicker, .Guests, .Location, .Photo]
        }
    }
    
    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var guestsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var photoView: RoundedImage!

    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    let defaultDuration = Double(2 * 60 * 60)
    
    weak var delegate: NewSpartyDelegate?
    
    var sparty = Sparty()
    var isDatePickerVisible = false
    var isDurationPickerVisible = false
    
    var vm: NewSpartyVM!
    
    
    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vm = NewSpartyVM(sparty: self.sparty, controller: self)

        tableView.tableFooterView = UIView()
        self.descriptionField.showPlaceholder("Sparty description")
        
        setupDatePicker()
        setupDurationPicker()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true)
    }
    
    //MARK: - Setup
    //--------------------------------------------------------------------------
    private func setupDatePicker() {
        self.datePicker.minimumDate = NSDate()
        self.datePicker.addTarget(self, action: #selector(NewSpartyTVC.handleDatePicker), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    private func setupDurationPicker() {
        self.durationPicker.addTarget(self, action: #selector(NewSpartyTVC.handleDurationPicker), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        self.vm.date = sender.date
    }
    
    @objc private func handleDurationPicker(sender: UIDatePicker) {
        self.vm.duration = sender.countDownDuration
    }
    
    // MARK: - Table View
    //--------------------------------------------------------------------------
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = Row(rawValue: indexPath.row)
        
        if row == .Date { //Date Picker
            self.view.endEditing(true)
            if self.vm.date == nil {
                self.vm.date = NSDate()
            }
            showHideCell(.DatePicker)
        } else if row == .Duration { //Duration Picker
            self.view.endEditing(true)
            if self.vm.duration == nil {
                self.vm.duration = self.defaultDuration
                self.durationPicker.countDownDuration = self.defaultDuration
            }
            showHideCell(.DurationPicker)
        }
    
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let row = Row.allRows()[indexPath.row]
        let height = super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
        switch row {
        case .DatePicker:
            return self.isDatePickerVisible == true ? height : 0
        case .DurationPicker:
            return self.isDurationPickerVisible == true ? height : 0
        default:
            return height
        }
    }
    
    private func showHideCell(row:Row) {
        
        switch row {
        case .DatePicker:
            self.isDatePickerVisible = !self.isDatePickerVisible
        case .DurationPicker:
            self.isDurationPickerVisible = !self.isDurationPickerVisible
        default:
            break
        }
        let indexPath = NSIndexPath(forRow: row.rawValue, inSection: 0)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.tableView.endUpdates()
        })
        
    }
    
    // MARK: - Navigation
    //--------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
 

    //MARK: - Text View Delegate
    //--------------------------------------------------------------------------
    func textViewDidChange(textView: UITextView) {
        
        self.showHidePlaceholder()
    }
    
    func showHidePlaceholder() {
        if self.descriptionField.text.characters.count > 0 {
            self.descriptionField.hidePlaceholder()
        }
        else {
            self.descriptionField.showPlaceholder("Sparty description")
        }
    }

    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func cancelAction(sender: AnyObject) {
        
        view.endEditing(true)
        showCancelAlert()
    }
    
    @IBAction func saveAction(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func showErrorMessage(message:String) {
        showHeaderView(message, textColor: UIColor.whiteColor(), backgroundColor: UIColor.primaryColor(), duration: 0.2)
    }
    
    private func hideErrorMessage() {
        hideHeaderView(0.2)
    }
    
    //MARK - Alerts
    //--------------------------------------------------------------------------
    private func showCancelAlert() {
        let alertController = UIAlertController(title: "Cancel", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
            self.view.endEditing(true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
