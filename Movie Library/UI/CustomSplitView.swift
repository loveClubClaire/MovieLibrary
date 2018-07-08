//
//  CustomSplitView.swift
//  Movie Library
//
//  Created by Zachary Whitten on 7/8/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class CustomSplitView: NSSplitView, NSSplitViewDelegate {

    func viewDidLoad(){
        delegate = self
    }
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool{
        if subview.identifier!.rawValue == "left"{
            return true
        }
        return false
    }

    
}
