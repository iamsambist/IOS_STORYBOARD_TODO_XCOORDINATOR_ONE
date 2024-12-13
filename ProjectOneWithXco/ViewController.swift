//
//  ViewController.swift
//  ProjectOneWithXco
//
//  Created by MacBook Two on 13/12/2024.
//

import UIKit
import XCoordinator

class ViewController: UIViewController {
    var onAddItemTapped: (() -> Void)?
    var showTask: ((String) -> Void)?
    var entryViewController : EntryViewController?
    
    // for deleting task action
    var deleteTaskFlag : Bool = false
    var deleteTaskValue : String = ""
    
    //
    @IBOutlet var tableView : UITableView!
    var message : String?
    var tasks = [String](){
        didSet {
            print("updated array = \(tasks)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: .done, target: self, action: #selector(addItemTapped))
        
   
   
    
    }
    func resetDeleteFlags(){
        self.deleteTaskFlag = false
        self.deleteTaskValue = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let unWrappedMessage = message else { return }
        if(!unWrappedMessage.isEmpty){
            tasks.append(unWrappedMessage)
            self.message = ""
        }
        if(deleteTaskFlag){
            if(!deleteTaskValue.isEmpty){
                removeAndRearrange(array: &tasks, target: deleteTaskValue)
            }
           resetDeleteFlags()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func removeAndRearrange(array: inout [String], target: String) {
        // Check if the target exists in the array
        if let index = array.firstIndex(of: target) {
            array.remove(at: index)
        }
    }
    
    @objc func addItemTapped() {
        onAddItemTapped?()
    }


}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskMessage = tasks[indexPath.row]
        self.showTask!(taskMessage)
    }
    
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
}

