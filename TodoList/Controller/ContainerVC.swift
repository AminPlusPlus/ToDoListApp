//
//  ViewController.swift
//  TodoList
//
//  Created by Aminjoni Abdullozoda on 8/18/18.
//  Copyright © 2018 Aminjoni Abdullozoda. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController
{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var connectionButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Making button round
        addButton.layer.cornerRadius = addButton.frame.width / 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

