//
//  ViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 20/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToLifeDo: SwipTableViewController {
    
    
    var taskArray : Results<Item>?
    
    var realm = try! Realm()
    
    @IBOutlet weak var searchbar: UISearchBar!
    //var catogaryColour : String = ""
    
    var selectedCatogary : Catogary? {
        
        didSet{
            loadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 69.0
        tableView.separatorStyle = .none
        
        
        if let colourHexa = selectedCatogary?.colour{
            navigationController?.navigationBar.barTintColor = UIColor(hexString: colourHexa)
        }
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if let colourHexa = selectedCatogary?.colour{
            title = selectedCatogary!.name
            
            guard let nav = navigationController?.navigationBar else {
                fatalError("App crashed")
            }
            if let navBarColour = UIColor(hexString: colourHexa){
                nav.barTintColor = navBarColour
                searchbar.barTintColor = navBarColour
                nav.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                nav.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
            }
            
            
                    }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if  let item = taskArray?[indexPath.row]{
        
        cell.textLabel?.text = item.list
            
            if let colour = UIColor(hexString: selectedCatogary!.colour)?.darken(byPercentage: CGFloat(indexPath.row ) / CGFloat(taskArray!.count)){
                
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
                
            }
            
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
    
    override func updatDataModel(at indexPath: IndexPath) {
        
        if let itemForDeletion = self.taskArray?[indexPath.row] {
            
            do{
                try realm.write {
                    realm.delete(itemForDeletion)
                }
                
            }catch{
                print("Error While Deleting Item \(error)")
            }
            
        }
        
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
