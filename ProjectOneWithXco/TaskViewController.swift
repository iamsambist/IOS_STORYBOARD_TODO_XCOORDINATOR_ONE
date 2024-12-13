//
//  TaskViewController.swift
//  ProjectOneWithXco
//
//  Created by MacBook Two on 13/12/2024.
//

import UIKit

class TaskViewController: UIViewController {
    
    var message : String = ""
    
    var deleteButtonTapped : ((String)->Void)?

    @IBOutlet var label : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = message
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        deleteButtonTapped?(message)
    }
}
