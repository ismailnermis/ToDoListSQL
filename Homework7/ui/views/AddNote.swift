//
//  AddNote.swift
//  Homework7
//
//  Created by İsmail Nermiş on 5.10.2023.
//

import UIKit

class AddNote: UIViewController {
    
    @IBOutlet weak var tfNote: UITextField!
    
    var viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func buttonSave(_ sender: Any) {
        if let name = tfNote.text {
            viewModel.save(name: name)
        }
    }
    
    
}
