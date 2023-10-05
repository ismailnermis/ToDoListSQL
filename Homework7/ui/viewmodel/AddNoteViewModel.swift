//
//  AddNoteViewModel.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import Foundation

class AddNoteViewModel {
    
    var krepo = TodoDaoRepository()
    
    func save(name: String){
        krepo.save(name: name)
    }
}
