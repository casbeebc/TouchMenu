//
//  ViewController.swift
//  TouchMenu
//
//  Created by brett on 7/15/15.
//  Copyright (c) 2015 DataMingle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TouchMenuDelegate {
    
    var selectedNodes:[UITouch:NSObject] = [UITouch:NSObject]()
    
    var touchMenu: TouchMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let touchMenuItems = [
            TouchMenuItem(label: "Add", subItems: []),
            TouchMenuItem(label: "Delete", subItems: []),
            TouchMenuItem(label: "Edit", subItems: []),
            TouchMenuItem(label: "Help", subItems: [])
        ]
        
        touchMenu = TouchMenu(viewController: self, view: view, touchMenuItems: touchMenuItems)
        
        touchMenu.touchMenuDelegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touches = touches as! Set<UITouch>
        
        for touch:UITouch in touches {
            
            let view = touch.locationInView(self.view)
            /*
            let node:NSObject? = self.nodeAtPoint(location) as? NSObject
            // Assumes sprites are named "sprite"
            if (node?.name == "sprite") {
            let touchObj = touch as UITouch
            selectedNodes[touchObj] = node!
            }
            */
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touches = touches as! Set<UITouch>
        
        for touch:UITouch in touches {
            let location = touch.locationInView(self.view)
            /*
            let touchObj = touch as UITouch
            // Update the position of the sprites
            if let node:NSObject? = selectedNodes[touchObj] {
            node?.position = location
            }
            */
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touches = touches as! Set<UITouch>
        
        for touch:UITouch in touches {
            
            if let exists:AnyObject? = selectedNodes[touch] {
                selectedNodes[touch] = nil
            }
        }
    }
    
    func menuItemSelected(menu: TouchMenu, menuItem: TouchMenuItem) {
        
    }
    
}
