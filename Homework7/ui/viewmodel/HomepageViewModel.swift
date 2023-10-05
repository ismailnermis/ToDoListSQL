//
//  HomepageViewModel.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import Foundation
import RxSwift

class HomepageViewModel {
    var krepo = TodoDaoRepository()
    var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    init(){
        krepo.copyDatabase()
        todoList = krepo.noteList
    }
    
    func search(searchWord : String){
        krepo.search(searchWord: searchWord)
    }
    
    func delete(id : Int){
        krepo.delete(id: id)
        loadNotes()
    }
    
    func loadNotes(){
        krepo.loadNotes()
    }
    
    
}
