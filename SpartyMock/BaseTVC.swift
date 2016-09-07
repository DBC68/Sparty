//
//  ViewController.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class BaseTVC: UITableViewController {
    
    //MARK - Properties
    //--------------------------------------------------------------------------
    var rows = [CellDescriptor]()
    var firstResponderIndex:Int?
    private var hasGoneTofirstField = false
    var selectColor = UIColor(red:0.00, green:0.58, blue:0.97, alpha:1.00) //Apple blue
    var unselectColor = UIColor.lightGrayColor()
    
    //MARK - View Life Cycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        handleSelectionCallbacks()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if hasGoneTofirstField == false {
            goToFirstField()
            hasGoneTofirstField = true
        }
    }
    
    //MARK - Setup
    //--------------------------------------------------------------------------
    func goToFirstField() {
        if let index = self.firstResponderIndex {
            
            if index >= 0 && index < rows.count {
                
                let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                
                if let textFieldCell = cell as? TextFieldCell {
                    textFieldCell.field.becomeFirstResponder()
                }
                    
                else if let textViewCell = cell as? TextViewCell {
                    textViewCell.textView.becomeFirstResponder()
                }
                else {
                    print("First responder index is not a textField or textView.")
                }
                
            }
            else {
                print("First responder index out of bounds.")
            }
        }
    }
    
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        tableView.registerNib(UINib(nibName: CellType.BasicCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.BasicCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.RightDetailCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.RightDetailCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.DatePickerCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.DatePickerCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.ItemPickerCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.ItemPickerCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.TextFieldCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.TextFieldCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.TextViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.TextViewCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.SubtitleCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.SubtitleCell.rawValue)
        tableView.registerNib(UINib(nibName: CellType.PhotoCell.rawValue, bundle: nil), forCellReuseIdentifier: CellType.PhotoCell.rawValue)
    }
    
    
    //MARK - TableView
    //--------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let descriptor = self.rows[indexPath.row]
        
        switch descriptor.cellType! {
            
        case .BasicCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? BasicCell {
                cell.cellDescriptor = descriptor
                return cell
            }
            
        case .RightDetailCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? RightDetailCell {
                cell.selectColor = self.selectColor
                cell.cellDescriptor = descriptor
                return cell
            }
            
        case .DatePickerCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? DatePickerCell {
                cell.cellDescriptor = descriptor as? DateDescriptor
                return cell
            }
        case .DateCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? RightDetailCell {
                cell.selectColor = self.selectColor
                cell.cellDescriptor = descriptor
                return cell
            }
        case .ItemPickerCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? ItemPickerCell {
                cell.cellDescriptor = descriptor as? ItemDescriptor
                return cell
            }
            
        case .TextFieldCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? TextFieldCell {
                cell.cellDescriptor = descriptor
                return cell
            }
            
        case .TextViewCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? TextViewCell {
                cell.cellDescriptor = descriptor
                return cell
            }
        case .RightSegueCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? RightDetailCell {
                cell.cellDescriptor = descriptor
                return cell
            }
        case .SubtitleCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? SubtitleCell {
                cell.cellDescriptor = descriptor
                return cell
            }
            
        case .PhotoCell:
            if let cell = tableView.dequeueReusableCellWithIdentifier(descriptor.cellId, forIndexPath: indexPath) as? PhotoCell {
                cell.cellDescriptor = descriptor
                cell.controller = self
                return cell
            }
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let descriptor = rows[indexPath.row]
            if descriptor.cellType == .PhotoCell {
                return 100
            } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //selectedRow is the cellDescriptor of the selected row
        let selectedRow = rows[indexPath.row]
        
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //If cell descriptor contains a child row is it expandable
        if let childRow = selectedRow.child {
            
            let childIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: 0)
            
            //Shows or hides row depending on current state
            
            //Show
            if selectedRow.isExpanded == false {
                
                selectedRow.isExpanded = true
                
                
                //Hide keyboard
                tableView.endEditing(true)
                
                //Called any time a row is selected
                NSNotification.dataEntered()
                
                if selectedRow.value == nil {
                    
                    if let value = selectedRow.defaultValue as? Titleable {
                        selectedRow.subtitle = value.title()
                        selectedRow.value = value.data()
                    }

                }
                
                
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
                //Add child row
                childRow.parent = selectedRow
                rows.insert(childRow, atIndex: childIndexPath.row)
                tableView.beginUpdates()
                tableView.insertRowsAtIndexPaths([childIndexPath], withRowAnimation: .Fade)
                tableView.endUpdates()
            }
            //Hide
            else {
                rows.removeAtIndex(childIndexPath.row)
                selectedRow.isExpanded = false
                tableView.beginUpdates()
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                tableView.deleteRowsAtIndexPaths([childIndexPath], withRowAnimation: .Fade)
                tableView.endUpdates()
                
            }
            
        }
        else if let segueId = selectedRow.segueId {
            performSegueWithIdentifier(segueId, sender: selectedRow)
        }
    }
    
    
    //MARK - Selection Callbacks
    //--------------------------------------------------------------------------
    func handleSelectionCallbacks() {
        
        NSNotificationCenter.defaultCenter().addObserverForName(DynamicTableView.Notification.SelectionCallback, object: nil, queue: nil) { (notification) in
            
            guard let descriptor = notification.userInfo?[DynamicTableView.Key.SelectedItemDescriptor] as? CellDescriptor else {return}
            
            switch descriptor.cellType! {
                
            case .DatePickerCell:
                if let childDescriptor = descriptor as? DateDescriptor,
                    value = childDescriptor.value as? Titleable,
                    date = value.data() as? NSDate {
                    childDescriptor.parent?.value = date
                    childDescriptor.parent?.subtitle = date.stringify(dateFormat:childDescriptor.dateFormat, timeFormat:childDescriptor.timeFormat)
                }
                
            case .ItemPickerCell:
                
                descriptor.parent?.value = descriptor.value
                if let value = descriptor.value as? Titleable {
                    descriptor.parent?.subtitle = value.title()
                }
                
            case .RightDetailCell:
                
                if let value = descriptor.value as? Titleable {
                    descriptor.title = value.title()
                }
                
            case .SubtitleCell:
            
                if let value = descriptor.value as? Titleable {
                    descriptor.title = value.title()
//                    descriptor.subtitle = value.subtitle
                }
                
            default:
                break
            }
            
            NSNotification.dataEntered()
            
            //Reload parent cell if child has a parent
            if let parent = descriptor.parent {
                
                if let index  = self.rowIndexOfDescriptor(parent) {
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forItem: index, inSection:0)], withRowAnimation: .None)
                }
            }
                //Else reload cell
            else {
                 if let index  = self.rowIndexOfDescriptor(descriptor) {
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forItem: index, inSection:0)], withRowAnimation: .None)
                }
            }
        }
    }
    
    func rowIndexOfDescriptor(descriptor: CellDescriptor) -> Int? {
        
        for (index, row) in self.rows.enumerate() {
            
            //Child descriptors don't have keys
            if row.key != nil {
                if row.key == descriptor.key {
                    return index
                }
            }
        }
        
        return nil
    }
    
    func closeAllRows() {
        
        view.endEditing(true)
        var count = rows.filter({ $0.isExpanded == true }).count
        
        var removedCells = [NSIndexPath]()
        
        for (i,row) in rows.enumerate() {
            if row.parent != nil {
                removedCells.append(NSIndexPath(forRow: i, inSection:0))
            }
        }
        
        if removedCells.count == 0 { return}
        
        while count > 0 {
            for (j,row) in rows.enumerate() {
                if row.isExpanded {
                    rows.removeAtIndex(j + 1)
                    row.isExpanded = false
                    count -= 1
                    break
                }
            }
        }
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths(removedCells, withRowAnimation: .Fade)
        tableView.endUpdates()
        
    }
    
    func dataDictionary() -> [String:AnyObject] {
        
        var dict = [String:AnyObject]()
        
        for row in rows {
            
            if let key = row.key {
                dict[key] = row.value != nil ? row.value : row.defaultValue
            }
        }
        
        return dict
    }
    
}

