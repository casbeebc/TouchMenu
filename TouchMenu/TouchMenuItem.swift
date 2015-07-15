//
//  TouchMenuItem.swift
//  TouchMenu
//
//  Created by brett on 7/15/15.
//  Copyright (c) 2015 DataMingle. All rights reserved.
//

import UIKit

class TouchMenuItem: NSObject
{
    let label: String
    let subItems: [TouchMenuItem]?
    
    init(label: String, subItems: [TouchMenuItem]? = nil)
    {
        self.label = label
        self.subItems = subItems
    }
}
