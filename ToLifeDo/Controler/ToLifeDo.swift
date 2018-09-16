//
//  ViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 20/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import RealmSwift

class ToLifeDo: UITableViewController {
    
    
    var taskArray : Results<Item>?
    
    var realm = try! Realm()
    
    
    
    var selectedCatogary : Catogary? {
        
        didSet{
            loadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskToDo", for: indexPath)
        
        if  let item = taskArray?[indexPath.row]{
        
        cell.textLabel?.text = item.list
        cell.accessoryType = item.done == true ? .checkmark : .none
            
        }else{
             cell.textLabel?.text = "No Items Added Yet"
            
        }
        
        return cell
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskArray?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = taskArray?[indexPath.row]{
            do{
            try realm.write {
                
                item.done = !item.done
            }
            }catch{
                print("Error While Updating")
            }
            
        }

        
        tableView.reloadData()
        
        

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           
            
            
            if let currentCatogary = self.selectedCatogary {
                do{
                try self.realm.write {
                    let item = Item()
                    item.list = textField.text!
                    item.dateCreated = Date()
                    currentCatogary.items.append(item)
                }
                }catch{
                    print("Error While saving")
                }
                
            }
            
            
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add New Item"
            
            textField = alertTextField
        }
        
        
        present(alert, animated: true , completion: nil)
        
        
        
        
    }
    
    func loadData(){
        
        taskArray = selectedCatogary?.items.sorted(byKeyPath: "list", ascending: true)
        tableView.reloadData()
        
    }
    
        
    }

    

    



extension ToLifeDo : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        taskArray = taskArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
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
