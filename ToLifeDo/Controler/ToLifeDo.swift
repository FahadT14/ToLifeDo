//
//  ViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 20/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import CoreData

class ToLifeDo: UITableViewController {
    
    
    var taskArray = [TodoItem]()
    
    var selectedCatogary : Catogary? {
        
        didSet{
            loadData()
        }
    }
    
//
//     let datapath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//
    //let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
//        if let item = defaults.array(forKey: "TodoListArray") as? [TodoItem] {
//            taskArray = item
//
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskToDo", for: indexPath)
        
        let item = taskArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
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
        
        
        
        //taskArray[indexPath.row].done = !taskArray[indexPath.row].done
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(taskArray[indexPath.row])
        
        taskArray.remove(at: indexPath.row)
        
        
        
      
        
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
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newItem = TodoItem(context: context)
            
            newItem.title = textField.text!
            newItem.done = false
            newItem.catogary = self.selectedCatogary
            
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
        
        do{
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
            
          } catch {
            
            print("Error Saving Context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadData(with request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest(), predicate : NSPredicate? = nil){
        
        let catogaryPredicate = NSPredicate(format: "catogary.name MATCHES %@", selectedCatogary!.name!)
        
        if let addictionalPredicate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catogaryPredicate , addictionalPredicate])
        } else {
            request.predicate = catogaryPredicate
        }
        
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catogaryPredicate, predicate])
//
//        request.predicate = compoundPredicate
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        
           taskArray = try context.fetch(request)
            
        }catch{
            print(error)
            
            
        }
        tableView.reloadData()
    }
    
  
    

}

extension ToLifeDo : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        let predicater = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.predicate = predicater
        
        let sortDesc = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDesc]
        
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

       loadData(with: request , predicate: predicater)
        
        tableView.reloadData()
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
           loadData()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
            
            
        }
    }
    
    
}

