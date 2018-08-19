//
//  ViewController.swift
//  ToLifeDo
//
//  Created by Fahad Tariq on 20/08/2018.
//  Copyright © 2018 Fahad Tariq. All rights reserved.
//

import UIKit

class ToLifeDo: UITableViewController {
    
    
    let taskArray = ["Any thing", "Hello Baby", "What's up"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskToDo", for: indexPath)
        
        cell.textLabel?.text = taskArray[indexPath.row]

        return cell
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(taskArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}

