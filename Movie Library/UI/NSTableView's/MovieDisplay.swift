//
//  MovieDisplay.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/13/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class MovieDisplay: NSObject, NSTableViewDataSource, NSTableViewDelegate{

    @IBOutlet weak var tableView: NSTableView!
    
    var movieData: [Movie] = []
    
    //Called by AppDelegate after application has finished launching. Think of this function as an initalization function
    func viewDidLoad(){
        
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return movieData.count;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //Get the column identifer and create an empty cellView variable
        let identifier = tableColumn?.identifier.rawValue
        
        var cellView: NSTableCellView?
        
        
        if identifier == "title" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TitleCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].title ?? ""
        }
        
    
        // return the populated NSTableCellView
        return cellView
    }
    
    @IBAction func TableViewClicked(_ sender: Any) {
        if tableView.selectedRowIndexes.isEmpty {
            //TODO disable edit and delete menu items
        }
        else{
            //TODO enable edit and delete menu items 
        }
    }
}
