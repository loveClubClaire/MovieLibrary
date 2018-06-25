//
//  SidebarViewController.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/23/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class SidebarOutlineView: NSOutlineView, NSOutlineViewDataSource, NSOutlineViewDelegate {

    
    let groups = ["Library", "Playlists"]
    let libItems = ["Movies"]
    let playlistItems = ["Something Else"]
    
    
    func viewDidLoad() {
        // Do view setup here.
        self.dataSource = self
        self.delegate = self
        self.expandItem(nil, expandChildren: true)
        
    }
    
    //NSOutlineView
    //
//    override func frameOfCell(atColumn column: Int, row: Int) -> NSRect {
//        let superFrame = super.frameOfCell(atColumn: column, row: row)
//        if column == 0{
//            return NSMakeRect(0, superFrame.origin.y, self.bounds.size.width, superFrame.size.height)
//        }
//        return superFrame
//    }
    
    
    //NSOutlineViewDataSource
    
    // Number of items in the sidebar
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item as? String == groups[0]{
            return libItems.count
        }
        else if item as? String == groups[1]{
            return playlistItems.count
        }
        return groups.count
    }
    
    // Items to be added to sidebar
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item as? String == groups[0]{
            return libItems[index]
        }
        else if item as? String == groups[1]{
            return playlistItems[index]
        }
        return groups[index]
    }
    
    // Whether rows are expandable by an arrow
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if item as? String == groups[0] || item as? String == groups[1]{
            return true
        }
        else{
            return false
        }
        
    }
    
    // Height of each row
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 20.0
    }
    
    
    
    
   //NSOutlineViewDelegate
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view: NSTableCellView?
        
        if let title = item as? String {
            view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ItemCell"), owner: self) as? NSTableCellView
            
            if let textField = view?.textField {
                 textField.stringValue = title
                if title == groups[0] || title == groups[1]{
                    textField.textColor = NSColor.gray
                }
        }
            
            
            
        }
        
        return view
    }
    
    //Prevent specific rows in the NSOutlineView from being selected
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool{
        if item as? String == groups[0] || item as? String == groups[1]{
            return false
        }
        else{
            return true
        }
    }
    
    //Hide the disclosure triangle of the rows in the NSOutlineView
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool{
        return false
    }
    

    
}
