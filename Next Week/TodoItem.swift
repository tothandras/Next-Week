//
//  TodoItem.swift
//  Next Week
//
//  Created by Andras Toth on 11/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import Parse

class TodoItem: Printable {
    class var className: String {
        get {return "TodoItem"}
    }
    
    var name: String
    var note: String
    var categories: [String]
    var deadline: NSDate
    var priority: Priority = Priority.Normal
    var state = States.Created
    // TODO
    var subTasks = [Task]()
    var id: String?
    
    enum Fields: String {
        case Name = "name"
        case Note = "note"
        case Categories = "categories"
        case Deadline = "deadline"
        case Priority = "priority"
        case State = "state"
        case subTasks = "subTasks"
    }
    
    var description: String {
        get {
            return "{name: \(name), description: \(note), categories: \(categories), deadline: \(deadline), subTasks: \(subTasks)}"
        }
    }
    
    init(name: String, note: String, categories: [String], deadline: NSDate) {
        self.name = name
        self.note = note
        self.categories = categories
        self.deadline = deadline
    }
    
    convenience init(object: PFObject) {
        let name = object[TodoItem.Fields.Name.rawValue] as String
        let note = object[TodoItem.Fields.Note.rawValue] as String
        let categories = object[TodoItem.Fields.Categories.rawValue] as [String]
        let deadline = object[TodoItem.Fields.Deadline.rawValue] as NSDate
        let priority = object[TodoItem.Fields.Priority.rawValue] as Int
        let state = object[TodoItem.Fields.State.rawValue] as String
        let subTasks = object[TodoItem.Fields.subTasks.rawValue] as [Task]

        self.init(name: name, note: note, categories: categories, deadline: deadline)
        self.state = States(rawValue: state)!
        self.subTasks = subTasks
        self.priority = Priority(rawValue: priority)!
        self.id = object.objectId
    }
    
    func toObject() -> PFObject {
        var object = PFObject(className: TodoItem.className)
        object[TodoItem.Fields.Name.rawValue] = name
        object[TodoItem.Fields.Note.rawValue] = note
        object[TodoItem.Fields.Categories.rawValue] = categories
        object[TodoItem.Fields.Deadline.rawValue] = deadline
        object[TodoItem.Fields.Priority.rawValue] = priority.rawValue
        object[TodoItem.Fields.State.rawValue] = state.rawValue
        object[TodoItem.Fields.subTasks.rawValue] = subTasks
        if let objectId = id {
            object.objectId = objectId
        }
        return object
    }

}
