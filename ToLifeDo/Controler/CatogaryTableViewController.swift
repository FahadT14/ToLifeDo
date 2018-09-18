//
//  CatogaryTableViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 30/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CatogaryTableViewController: SwipTableViewController{
    
    let realm = try! Realm()
    
    
    
    var catogaryArray : Results<Catogary>?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
         
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let catogary = catogaryArray?[indexPath.row]{
            
            guard let colour = UIColor(hexString: catogary.colour) else {fatalError()}
            cell.textLabel?.text = catogary.name
            cell.backgroundColor = colour
            cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
        }
        
       
        
      
        
        
        
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
            //destinationVC.catogaryColour = catogaryArray?[indexPath.row].colour ?? "1D9BF6"
        }
        
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (alert) in
            
            
            let cat = Catogary()
            
            cat.name = textField.text!
            
            cat.colour = UIColor.randomFlat.hexValue()
            
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
    
    override func updatDataModel(at indexPath: IndexPath) {
        
        if let catogaryForDeletion = self.catogaryArray?[indexPath.row]{
                            do{
            
                                try self.realm.write {
                                    self.realm.delete(catogaryForDeletion)
                                }
                            }catch{
                                print("Error While deleting")
                            }
            
                        }
    }
    
}


    

