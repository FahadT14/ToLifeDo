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
    
     let datapath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(datapath)
        loadData()
//        if let item = defaults.array(forKey: "TodoListArray") as? [TodoItem] {
//            taskArray = item
//
//        }
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
        
        saveData()
        
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
            
            self.saveData()
            
            
            
            
           //self.defaults.setValue(self.taskArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add New Item"
            
            textField = alertTextField
        }
        
        
        present(alert, animated: true , completion: nil)
        
        
        
        
    }
    
    // Enconding the data with NSCODER
    
    func saveData(){
        
        let encoder = PropertyListEncoder()
        
        do{
            
            
            let data = try encoder.encode(taskArray)
            try data.write(to: datapath!)
            
        } catch {
            
            print("Error encoing the array \(error)")
            
        }
        
    }
    
    func loadData(){
        
            
        if let data = try? Data(contentsOf: datapath!){
            
            let decoder = PropertyListDecoder()
            do{
                taskArray = try decoder.decode([TodoItem].self, from: data)
            } catch{
                
                print("Decoder Error")
                
            }
        }
    }
    
    
    
}

