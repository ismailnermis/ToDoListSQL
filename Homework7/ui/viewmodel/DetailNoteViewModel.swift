//
//  DetailNoteViewModel.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import Foundation

class DetailNoteViewModel {
    var krepo = TodoDaoRepository()
    
    func update(id: Int, name: String){
        krepo.update(id: id, name: name)
    }
}
