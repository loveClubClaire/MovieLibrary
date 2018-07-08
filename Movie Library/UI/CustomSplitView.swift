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
        //Set a unique autosave name so the configuration of the colums persist over app launches
        self.autosaveName = NSSplitView.AutosaveName(rawValue: "CustomSplitViewSave")
    }
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool{
        if subview.identifier!.rawValue == "left"{
            return true
        }
        return false
    }

    
}
