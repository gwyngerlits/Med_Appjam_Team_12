//
//  GoToMainViewController.swift
//  Voice
//
//  Created by Kay Lab on 11/15/15.
//  Copyright © 2015 Team12. All rights reserved.
//

import UIKit

class GoToMainViewController: UIViewController {
    // MARK: Settup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        showTest = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}