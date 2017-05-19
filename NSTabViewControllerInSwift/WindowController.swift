//
//  WindowController.swift
//  NSTabViewControllerInSwift
//
//  Created by Daniel Pink on 19/5/17.
//  Copyright © 2017 Daniel Pink. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        guard let tabViewController = contentViewController as? TabViewController else {
            fatalError("contentViewController should be a TabViewController but it isn't")
        }
        
        dump(tabViewController)
        
        let selectedIndex = tabViewController.selectedTabViewItemIndex
        let selectedTabViewItem = tabViewController.tabViewItems[selectedIndex]
        if let selectedViewController = selectedTabViewItem.viewController {
            switch selectedViewController {
            case is ViewControllerOne:
                print("Selected ViewController is of type ViewControllerOne")
                dump(selectedViewController)
            case is ViewControllerTwo:
                print("Selected ViewController is of type ViewControllerTwo")
                dump(selectedViewController)
            default:
                print("Mystery ViewController")
            }
        }
        
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49: // Space bar
            print("Spacebar")
            if let vc = contentViewController as? TabViewController {
                if vc.selectedTabViewItemIndex == 1 {
                    vc.tabView.selectTabViewItem(at: 0)
                } else {
                    vc.tabView.selectTabViewItem(at: 1)
                }
            }
        default:
            break
        }
    }
    
}
