//
//  DataProvider.swift
//  Next Week
//
//  Created by Andras Toth on 11/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import Parse

class DataProvider {
    
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
    
    class func getQuery() -> PFQuery {
        var query = PFQuery(className: TodoItem.className)
         query.orderByAscending(TodoItem.Fields.Deadline.rawValue)
        return query
    }
    
    class func deleteObject(object: PFObject) {
        object.deleteInBackgroundWithBlock(loggerCallBack(object, "delete"))
    }

    class func saveObject(object: PFObject) {
        object.saveInBackgroundWithBlock(loggerCallBack(object, "save"))
    }
    
    class func saveObjectEventually(object: PFObject) {
        object.saveEventually(loggerCallBack(object, "save"))
    }

}
