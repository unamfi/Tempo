//
//  ViewController.swift
//  Angel Hack
//
//  Created by Julio César Guzman on 5/7/16.
//  Copyright © 2016 Julio Guzman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let tableViewController = storyboard.instantiateViewControllerWithIdentifier("MainTableViewController")
        self.addChildViewController(tableViewController)
        tableViewController.view.frame = self.view.frame
        self.view.addSubview(tableViewController.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

