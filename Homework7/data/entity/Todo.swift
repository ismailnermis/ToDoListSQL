//
//  Todo.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import Foundation

class Todo {
    var id : Int?
    var name : String?
    
    init(){
        
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
