//
//  Homepage.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import UIKit
import RxSwift

class Homepage: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var todoList = [Todo]()
    var viewModel = HomepageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        _ = viewModel.todoList.subscribe(onNext: { list in
            self.todoList = list
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let note = sender as? Todo {
                let destinationVC = segue.destination as! DetailNote
                destinationVC.note = note
            }
        }
    }
    
}

extension Homepage : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchWord: searchText)
    }
}

extension Homepage : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoCell
        let note = todoList[indexPath.row]
        
        cell.labelNote.text = note.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let kisi = todoList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: kisi)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ contextualAction, view, bool in
            
            let note = self.todoList[indexPath.row]
            let alert = UIAlertController(title: "Delete Note", message: "Do you want to delete this note : \(note.name!)", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                
                self.viewModel.delete(id: note.id!)
            }
            alert.addAction(yesAction)
            
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
