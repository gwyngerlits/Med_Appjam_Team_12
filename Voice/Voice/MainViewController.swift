//
//  mainViewController.swift
//  Voice
//
//  Created by Kay Lab on 11/15/15.
//  Copyright © 2015 Team12. All rights reserved.
//
var showTest = true

import UIKit

class MainViewController: UITableViewController {
    // var for showing Reading Test
    
    @IBOutlet weak var test: UITableViewCell!
    
    // MARK: Settup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test.hidden = !showTest
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


