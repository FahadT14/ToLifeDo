//
//  CatogaryTableViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 30/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import RealmSwift

class CatogaryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    
    
    var catogaryArray : Results<Catogary>?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
         
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "CatogaryCell", for: indexPath)
        
        cell.textLabel?.text = catogaryArray?[indexPath.row].name ?? "No catagory added yet"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catogaryArray?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToLifeDo
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCatogary = catogaryArray?[indexPath.row] ?? catogaryArray?[0]
        }
        
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (alert) in
            
            
            let cat = Catogary()
            
            cat.name = textField.text!
            
            self.saveData(catogary: cat)
            
            self.tableView.reloadData()
            
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textfieldArea) in
            
            textfieldArea.placeholder = "Enter Items"
            
            textField = textfieldArea
            
        }
        
        present(alert , animated: true , completion: nil )
        
        
        
        
        
        
        
        
        
    }
    
    
    func saveData(catogary : Catogary) {
        
        
        
        do{
            try realm.write {
                realm.add(catogary)
            }
            
        }
        catch{
            print("Error While Saving")
            
            
        }
        self.tableView.reloadData()
        
        
    }
    
    func loadData(){
        
        catogaryArray = realm.objects(Catogary.self)
        
      }
}
