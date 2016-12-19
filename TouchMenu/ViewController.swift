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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touches = touches 
        
        for touch:UITouch in touches {
            
            _ = touch.location(in: self.view)
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touches = touches 
        
        for touch:UITouch in touches {
            _ = touch.location(in: self.view)
            /*
            let touchObj = touch as UITouch
            // Update the position of the sprites
            if let node:NSObject? = selectedNodes[touchObj] {
            node?.position = location
            }
            */
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touches = touches 
        
        for touch:UITouch in touches {
            
            if let _:AnyObject? = selectedNodes[touch] {
                selectedNodes[touch] = nil
            }
        }
    }
    
    func menuItemSelected(_ menu: TouchMenu, menuItem: TouchMenuItem) {
        
    }
    
}
