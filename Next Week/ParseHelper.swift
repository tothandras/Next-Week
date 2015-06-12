//
//  ParseHelper.swift
//  Next Week
//
//  Created by Andras Toth on 11/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import Parse

class ParseHelper {
    
    private class func loggerCallBack(object: Printable, _ action: String) -> (Bool, NSError?) -> Void {
        func logger(success: Bool, error: NSError?) {
            if (success) {
                println("\(action): \(object)")
            } else {
                println(error?.description)
            }
        }
        return logger
    }
    
    class func save(item: TodoItem) {
        var object = PFObject(className: TodoItem.className)
        object[TodoItem.Fields.Name.rawValue] = item.name
        object[TodoItem.Fields.Note.rawValue] = item.note
        object.saveInBackgroundWithBlock(loggerCallBack(item, "save"))
    }
    
    class func saveEventually(item: TodoItem) {
        var object = PFObject(className: TodoItem.className)
        object[TodoItem.Fields.Name.rawValue] = item.name
        object[TodoItem.Fields.Note.rawValue] = item.note
        object.saveEventually(loggerCallBack(item, "save"))
    }
    
    class func queryAll(callback: ([AnyObject]!, NSError!) -> Void) {
        var query = PFQuery(className: TodoItem.className)
        query.findObjectsInBackgroundWithBlock(callback)
    }
    
    class func delete(item: TodoItem) {
        if let id = item.id {
            var object = PFObject(className: TodoItem.className)
            object.objectId = id
            object.deleteInBackgroundWithBlock(loggerCallBack(item, "delete"))
        }
    }
}
