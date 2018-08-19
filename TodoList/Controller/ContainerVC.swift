//
//  ViewController.swift
//  TodoList
//
//  Created by Aminjoni Abdullozoda on 8/18/18.
//  Copyright © 2018 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController
{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var connectionButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    var todoTableVC : ToDoTableVC!
    
    let tableVCIdentifer = "TodoVC"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        

        
        
        
        //Making button round
        addButton.layer.cornerRadius = addButton.frame.width / 2
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == tableVCIdentifer
        {
            todoTableVC = (segue.destination as! UINavigationController).childViewControllers.first as! ToDoTableVC
        }
    }
    
    
    @IBAction func triggerConnection (_ sender :  UIButton)
    {
        
    }
    
    @IBAction func addItem (_ sender :  UIButton)
    {
        todoTableVC.addNewItem()
    }
    

}

