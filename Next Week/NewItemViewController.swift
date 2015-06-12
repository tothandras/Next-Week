//
//  NewItemViewController.swift
//  Next Week
//
//  Created by Andras Toth on 12/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import UIKit
import Parse

class NewItemViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var noteInput: UITextView!
    @IBOutlet weak var dateInput: UIDatePicker!
    @IBOutlet weak var priorityInput: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var now = NSDate()
        
        
        var components = NSDateComponents()
        components.setValue(10, forComponent: NSCalendarUnit.CalendarUnitDay);
        let date: NSDate = NSDate()
        var maxDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(0))
        
        dateInput.minimumDate = now
        dateInput.maximumDate = maxDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonTouch() {
        if let name = nameInput.text {
            if let note = noteInput.text {
                if let priority = priorityInput?.selectedSegmentIndex {
                    if let date = dateInput?.date {
                        var item = TodoItem(name: name, note: note, priority: Priority(rawValue: priority)!, deadline: date)
                        DataProvider.saveObject(item.toObject())
                    navigationController?.popToRootViewControllerAnimated(true)
                    }
                }
            }
        }
    }
}
