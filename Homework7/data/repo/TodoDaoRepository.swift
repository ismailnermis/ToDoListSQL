//
//  TodoDaoRepository.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import Foundation
import RxSwift

class TodoDaoRepository {
    
    var noteList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    let db : FMDatabase?
    
    init(){
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: target).appendingPathComponent("todos.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func save(name: String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO toDos (name) VALUES (?)", values: [name])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(id: Int, name: String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE toDos SET name=? WHERE id=?", values: [name,id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func search(searchWord : String){
        db?.open()
        
        var list = [Todo]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM toDos WHERE name like '%\(searchWord)%'", values: nil)
            
            while rs.next() {
                let id  = Int(rs.string(forColumn: "id"))!
                let name  = rs.string(forColumn: "name")!
                
                let note = Todo(id: id, name: name)
                list.append(note)
            }
            
            noteList.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func delete(id: Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM toDos WHERE id=?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func loadNotes(){
        db?.open()
        
        var list = [Todo]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while rs.next() {
                let id  = Int(rs.string(forColumn: "id"))!
                let name  = rs.string(forColumn: "name")!
                
                let note = Todo(id: id, name: name)
                list.append(note)
            }
            
            noteList.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func copyDatabase(){
        let bundle = Bundle.main.path(forResource: "todos", ofType: ".sqlite")
        let target = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyTarget = URL(fileURLWithPath: target).appendingPathComponent("todos.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: copyTarget.path){
            print("Database already exist.")
        }else{
            do{
                try fileManager.copyItem(atPath: bundle!, toPath: copyTarget.path)
            }catch{}
        }
    }
    
}
