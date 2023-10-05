//
//  DetailNote.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import UIKit

class DetailNote: UIViewController {
    
    @IBOutlet weak var tfNote: UITextField!
    
    var note : Todo?
    var viewModel = DetailNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = note {
            tfNote.text = note.name
        }
        
        
    }
    
    @IBAction func buttonUpdate(_ sender: Any) {
        if let name = tfNote.text, let note = note {
            viewModel.update(id: note.id!, name: name)
        }
    }
    
    
}
