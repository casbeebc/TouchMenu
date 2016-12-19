//
//  TouchMenuPanGestureRecognizer.swift
//  TouchMenu
//
//  Created by brett on 7/15/15.
//  Copyright (c) 2015 DataMingle. All rights reserved.
//

import UIKit

class TouchMenuPanGestureRecognizer: UIPanGestureRecognizer
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent)
    {
        super.touchesBegan(touches, with: event)
        
        state = UIGestureRecognizerState.began
    }
}
