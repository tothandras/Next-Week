//
//  DetailViewController.swift
//  Next Week
//
//  Created by Andras Toth on 11/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import Foundation
import UIKit
import Parse

class DetailViewController: UITableViewController {
    var object: PFObject?
    var item: TodoItem?
    
    var timeLeft: NSTimeInterval = NSTimeInterval() {
        didSet {
            var ti = NSInteger(timeLeft)
            var s = ti % 60
            var m = (ti / 60) % 60
            var h = (ti / 3600)
            println(s)
            if s < 0 {
                countdownLabel.text = "missed :("
                timer.invalidate()
            } else {
                countdownLabel.text = NSString(format: "%0.2d:%0.2d:%0.2d", h, m, s)
            }
        }
    }
    
    var timer = NSTimer()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UITextView!
    @IBOutlet weak var progressIndicator: UIProgressView!
    @IBOutlet weak var subTasksTable: UITableView!
    @IBOutlet weak var countdownLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let object = object {
            item = TodoItem(object: object)
            
            nameLabel.text = item?.name
            noteLabel.text = item?.note
            var allCount = 0.0
            var doneCount = 0.0
            if let tasks = item?.subTasks {
                for t in tasks {
                    allCount++
                    if t.state == .Done {
                        doneCount++
                    }
                }
            }
            progressIndicator.progress = 0.5
            if allCount == 0 {
                progressIndicator.progress = item!.state == .Done ? 1 : 0
            } else {
                progressIndicator.progress = Float(doneCount/allCount)
            }
        }

        updateCounter()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateCounter", userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        timeLeft = item!.deadline.timeIntervalSinceDate(NSDate())
    }
}
