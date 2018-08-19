//
//  ToDoTableVC.swift
//  TodoList
//
//  Created by Aminjoni Abdullozoda on 8/18/18.
//  Copyright © 2018 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableVC: UITableViewController {
    
    
    //MARK: - Core Data
    
    var resultController :  NSFetchedResultsController<Item>!
    let coreDataStack = PersistenceService()
    
    
    @IBOutlet weak var progressView: UIProgressView!
    var demoTodoList  = ["Learn Realm", "Clean Code", "java Start", "JSX"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return demoTodoList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoCell

        cell.title.text = demoTodoList[indexPath.row]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (Action, IndexPath) in
            
            print("Share")
        }
        
        shareAction.backgroundColor = .blue
        
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (Action, IndexPath) in
            
            print("Delete")
        }
        
        deleteAction.backgroundColor = .red
        
        
        
        return [deleteAction, shareAction]
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let accept = UIContextualAction(style: .normal, title: "Done") { (action, view, completed) in
            
            print("Done")
        }
        
        accept.backgroundColor = .darkGray
        
        return UISwipeActionsConfiguration(actions: [accept])
        
    }
    
    
    //MARK: -  adding New item to list and Connection
    
    func addNewItem()
    {
        
        let addAlert = UIAlertController(title: "Add Todo", message: "", preferredStyle: UIAlertControllerStyle.alert)
        addAlert.addTextField { (textField) in
            
            textField.placeholder = "Here type your Todo Item."
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let post = UIAlertAction(title: "Post", style: UIAlertActionStyle.default) { (_) in
            
           // let item = Item(context: PersistenceServce.context)
            item.title = addAlert.textFields![0].text!
            item.isCompleted = false
            
            
            self.demoTodoList.append(addAlert.textFields![0].text!)
            self.tableView.reloadData()
        }
        
        addAlert.addAction(cancel)
        addAlert.addAction(post)
        
      
        present(addAlert, animated: true, completion: nil)
        
    }
    
    func connectionTable()
    {
        
    }
    

    

}
