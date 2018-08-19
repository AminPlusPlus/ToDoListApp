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
    
    func initCoreDataCollection ()
    {
        //request
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescription = NSSortDescriptor(key: "date", ascending: true)
        
        request.sortDescriptors = [sortDescription]
        
        //Init
        resultController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: coreDataStack.manageContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        
        //fetch
        
        do {
        try resultController.performFetch()
        } catch
        {
            print("Error : \(error.localizedDescription)")
        }
        
    }
    
    
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init Core Data
        initCoreDataCollection()
        
        
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        print(resultController.sections?[section].objects?.count)
        
        return resultController.sections?[section].objects?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoCell

        let todo = resultController.object(at: indexPath)
        
        cell.title.text = todo.title

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
        
            
            let todo = Item(context: self.coreDataStack.manageContext)
            
            todo.title = addAlert.textFields![0].text!
            todo.isCompleted = false
            todo.date = Date()
            
            do {
                try self.coreDataStack.manageContext.save()
            } catch
            {
                print("Error Save Todo :  \(error.localizedDescription)")
            }
            
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
