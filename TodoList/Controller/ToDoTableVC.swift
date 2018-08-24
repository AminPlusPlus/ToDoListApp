//
//  ToDoTableVC.swift
//  TodoList
//
//  Created by Aminjoni Abdullozoda on 8/18/18.
//  Copyright © 2018 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit
import CoreData

struct Item {
    
    var title : String
    var isCompleted : Bool
    var saveTime : Date
    
}

class ToDoTableVC: UITableViewController {
    
    
    //MARK: - Core Data
    
    var items : [NSManagedObject] = []
    
    
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init Core Data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ItemData")
        
        do {
            items = try managedContext.fetch(fetchRequest)
            
            print(items.count)
        } catch
        {
            print("Fetch Problem  \(error.localizedDescription)")
        }
        
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
        return items.count
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoCell
      
        cell.title.text =  items[indexPath.row].value(forKeyPath: "title") as? String

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (Action, IndexPath) in
            
            print("Share")
        }
        
        shareAction.backgroundColor = .blue
        
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (Action, IndexPath) in
            
            self.items.remove(at: indexPath.row)
            self.coreDataSave()
            self.tableView.reloadData()
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
        
            self.saveItem((addAlert.textFields?[0].text)!)
            
            self.tableView.reloadData()
        }
        
        addAlert.addAction(cancel)
        addAlert.addAction(post)
        
      
        present(addAlert, animated: true, completion: nil)
        
        
    }
    
    func saveItem (_ item : String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ItemData", in: managedContext)
        let itemData = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        itemData.setValue(item, forKey: "title")
        
        do {
            try managedContext.save()
            items.append(itemData)
        } catch
        {
            print("Erro \(error.localizedDescription)")
        }
    }
    
    
    
    func connectionTable()
    {
        
    }
    
    func coreDataSave ()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
           try managedContext.save()
        } catch
        {
            print("Erro Save \(error.localizedDescription)")
        }
    }
    

    

}
