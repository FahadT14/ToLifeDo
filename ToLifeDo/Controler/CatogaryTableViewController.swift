//
//  CatogaryTableViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 30/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit
import CoreData

class CatogaryTableViewController: UITableViewController {
    
    
    var catogaryArray = [Catogary]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
         
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "CatogaryCell", for: indexPath)
        
        let item = catogaryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catogaryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToLifeDo
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCatogary = catogaryArray[indexPath.row]
        
        }
        
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (alert) in
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let cat = Catogary(context: context)
            
            cat.name = textField.text!
            
            self.catogaryArray.append(cat)
            
            self.saveData()
            
            self.tableView.reloadData()
            
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textfieldArea) in
            
            textfieldArea.placeholder = "Enter Items"
            
            textField = textfieldArea
            
        }
        
        present(alert , animated: true , completion: nil )
        
        
        
        
        
        
        
        
        
    }
    
    
    //Mark: - Core Data Funcationality
    
    
    
    func saveData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            try context.save()
            
        }
        catch{
            print("Error While Saving")
            
            
        }
        self.tableView.reloadData()
        
        
    }
    
    func loadData(){
        
        let request : NSFetchRequest<Catogary> = Catogary.fetchRequest()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            catogaryArray = try context.fetch(request)
            
            
        }catch {
            print("error while reloading")
            
        }
        tableView.reloadData()
        
    }
    

}
