//
//  TouchMenu.swift
//  TouchMenu
//
//  Created by brett on 7/15/15.
//  Copyright (c) 2015 DataMingle. All rights reserved.
//

import UIKit

class TouchMenu: NSObject
{
    let touchMenuContentViewController: TouchMenuContentViewController
    
    let touchMenuItems:[TouchMenuItem]
    
    let viewController: UIViewController
    let view: UIView
    
    var tap: TouchMenuPanGestureRecognizer!
    var previousTouchLocation = CGPoint.zero
    
    var selectedNodes:[UITouch:NSObject] = [UITouch:NSObject]()
    
    weak var touchMenuDelegate: TouchMenuDelegate? {
        didSet
        {
            touchMenuContentViewController.touchMenuDelegate = touchMenuDelegate
        }
    }
    
    init(viewController: UIViewController, view: UIView, touchMenuItems:[TouchMenuItem])
    {
        self.touchMenuItems = touchMenuItems
        
        let touchMenuOrigin = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        touchMenuContentViewController = TouchMenuContentViewController(origin: touchMenuOrigin)
        
        self.viewController = viewController
        self.view = view
        self.view.isUserInteractionEnabled = true
        
        super.init();
        
        touchMenuContentViewController.touchMenu = self
        
        tap = TouchMenuPanGestureRecognizer(target: self, action: #selector(TouchMenu.tapHandler(_:)))
        view.addGestureRecognizer(tap)
    }
    
    deinit
    {
        viewController.view.removeGestureRecognizer(tap)
    }
    
    fileprivate func open(_ locationInView: CGPoint)
    {
        touchMenuContentViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        touchMenuContentViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        touchMenuContentViewController.view.frame = view.bounds
        
        viewController.present(touchMenuContentViewController, animated: false) {
            _ = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
            self.touchMenuContentViewController.origin = locationInView
            self.touchMenuContentViewController.openTouchMenu(locationInView, touchMenuItems: self.touchMenuItems)
        }
    }
    
    func close()
    {
        touchMenuContentViewController.closeTouchMenu()
        viewController.dismiss(animated: false, completion: nil)
    }
    
    func tapHandler(_ recognizer: TouchMenuPanGestureRecognizer)
    {
        if recognizer.state == UIGestureRecognizerState.began
        {
            open(recognizer.location(in: view))
        }
        else if recognizer.state == UIGestureRecognizerState.changed
        {
            touchMenuContentViewController.handleMovement(recognizer.location(in: view))
        }
        else
        {
            close()
        }
    }
    
}

extension CGPoint
{
    func distance(_ otherPoint: CGPoint) -> Float
    {
        let xSquare = Float((self.x - otherPoint.x) * (self.x - otherPoint.x))
        let ySquare = Float((self.y - otherPoint.y) * (self.y - otherPoint.y))
        
        return sqrt(xSquare + ySquare)
    }
}
