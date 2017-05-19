//
//  TabViewController.swift
//  NSTabViewControllerInSwift
//
//  Created by Daniel Pink on 19/5/17.
//  Copyright © 2017 Daniel Pink. All rights reserved.
//

import Cocoa

class TabViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        tabView.delegate = self
    }
    
}
