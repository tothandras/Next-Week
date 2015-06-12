//
//  TableViewController.swift
//  Next Week
//
//  Created by Andras Toth on 11/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TableViewController: PFQueryTableViewController {

    required init(coder: NSCoder) {
        super.init(coder: coder)

        self.parseClassName = TodoItem.className
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 0.5)
        tableView.rowHeight = 100
        
        tableView.registerNib(UINib(nibName: "TodoViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func queryForTable() -> PFQuery {
        return DataProvider.getQuery()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as TodoViewCell
        
        var item = TodoItem(object: object!)
        cell.label?.text = item.name
        if item.subTasks.count > 0 {
            cell.taskCount?.text = "(\(item.subTasks.count))"   
        }
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        cell.day?.text = dateFormatter.stringFromDate(item.deadline).uppercaseString
        
        var color: UIColor?
        switch item.priority {
        case .Low:
            color = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 0.7)
        case .Normal:
            color = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 0.7)
        case .High:
            color = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.7)
        }
        cell.tintColor = color
        cell.accessoryType = .DetailButton
        if item.state == .Done {
            cell.accessoryType = .Checkmark
            cell.tintColor = UIColor.greenColor()
        }
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.removeObjectAtIndexPath(indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("details", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "details") {
            var detailViewController = segue.destinationViewController as DetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let row = Int(indexPath.row)
                detailViewController.object = (objects?[row] as PFObject)
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        let thisWeek = dateFormatter.stringFromDate(NSDate()).toInt()
        var map = [0:0, 1:0]
        if let objects = objects as? [PFObject] {
            for i in objects {
                var item = TodoItem(object: i)
                let deadlineWeek = dateFormatter.stringFromDate(item.deadline).toInt()
                let k = deadlineWeek!-thisWeek!;
                map[k]! += 1
            }
        }
        if section == 0 {
            return map[section]!
        } else if section == 1 {
            return map[section]!
        }
        return 0
    }
    
    override func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "This week" : "Next week"
    }
    
    @IBAction func add(sender: UIBarButtonItem) {
        println("asd")
    }
}
