//
//  ItemPickerCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class ItemPickerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var itemPicker: UIPickerView!
    
    //MARK - Properties
    //--------------------------------------------------------------------------
    
    var cellDescriptor: ItemDescriptor! {
        didSet {
            itemPicker.delegate = self
            itemPicker.dataSource = self
            
            if let data = cellDescriptor.value as? Titleable {
                
                let title = data.title
                
                if let index = pickerData.indexOf(title()) {
                    
                    itemPicker.selectRow(index, inComponent: 0, animated: false)
                }
            }
            
        }
    }
    
    var pickerData:[String] {
        
        guard let items = cellDescriptor.items else { return [String]() }
        
        let titleableItems = items.map({$0 as! Titleable})
        
        return titleableItems.map {$0.title()}
        
    }

   //MARK - Picker Delegate
    //--------------------------------------------------------------------------
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        cellDescriptor.value = cellDescriptor.items![row]
        
        NSNotification.selectionCallback(cellDescriptor)
    }

}
