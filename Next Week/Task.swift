//
//  Task.swift
//  Next Week
//
//  Created by Andras Toth on 11/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//


class Task {
    var state = States.Created
    var name: String
    
    init(name: String) {
        self.name = name
    }
}