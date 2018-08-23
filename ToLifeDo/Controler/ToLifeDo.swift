//
//  ViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 20/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit

class ToLifeDo: UITableViewController {
    
    
    var taskArray = [TodoItem]()
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = TodoItem()
        newItem.item = "Fahad"
        taskArray.append(newItem)
        
        let newItem1 = TodoItem()
        newItem1.item = "Ali"
        taskArray.append(newItem1)
        
        let newItem2 = TodoItem()
        newItem2.item = "Mustafa"
        taskArray.append(newItem2)
        
        
        if let item = defaults.array(forKey: "TodoListArray") as? [TodoItem] {
            taskArray = item

        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskToDo", for: indexPath)
        
        let item = taskArray[indexPath.row]
        
        cell.textLabel?.text = item.item
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//
//            cell.accessoryType = .none
//        }
        

        return cell
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(taskArray[indexPath.row])
        
        taskArray[indexPath.row].done = !taskArray[indexPath.row].done
//
//        if taskArray[indexPath.row].done == false{
//            taskArray[indexPath.row].done = true
//        }else{
//            taskArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//
//        else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = TodoItem()
            newItem.item = textField.text!
            
            self.taskArray.append(newItem)
    
           //self.taskArray.append(textField.text!)
            
           self.defaults.setValue(self.taskArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add New Item"
            
            textField = alertTextField
        }
        
        
        present(alert, animated: true , completion: nil)
        
        
        
        
    }
    
}

