//
//  EntryViewController.swift
//  ProjectOneWithXco
//
//  Created by MacBook Two on 13/12/2024.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet var taskTitle : UITextField!
    var onSaveTaskAction : ((String)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .done, target: self, action: #selector(saveButtonTapped))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        taskTitle.text = ""
    }
    
    @objc func saveButtonTapped() {
        guard let wrappedTaskTitle = taskTitle.text, !wrappedTaskTitle.isEmpty else { return }
        onSaveTaskAction?(wrappedTaskTitle)
        
        
    }
   
}

