//
//  GraphImage.swift
//  PDapp
//
//  Created by Audrey Lai on 11/13/15.
//  Copyright (c) 2015 Audrey Lai. All rights reserved.
//

import UIKit

class GraphImage: UIViewController {
    @IBOutlet var graph: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graph.image = UIImage(named: "Scatter_Plot.jpg")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}