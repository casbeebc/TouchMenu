//
//  TouchMenuDelegate.swift
//  TouchMenu
//
//  Created by brett on 7/15/15.
//  Copyright (c) 2015 DataMingle. All rights reserved.
//

import ObjectiveC


protocol TouchMenuDelegate: NSObjectProtocol
{
    func menuItemSelected(_ menu: TouchMenu, menuItem: TouchMenuItem)
}
