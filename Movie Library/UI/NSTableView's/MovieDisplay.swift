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
        tableView.autosaveName = NSTableView.AutosaveName(rawValue: "MovieDisplayTableView")
        tableView.autosaveTableColumns = true
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
    
   
    
    
    @IBAction func TableViewMenuItem(_ sender: Any){
        let menuItem = (sender as! NSMenuItem)
        
        menuItem.state == .off ? (menuItem.state = .on) : (menuItem.state = .off)
        
        
        var tableColumn: NSTableColumn? = nil
        if menuItem.title == "Aspect Ratio" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "aspectRatio")) }
        if menuItem.title == "Bit Rate" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "bitRate")) }
        if menuItem.title == "Comments" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "comments")) }
        if menuItem.title == "Director" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "director")) }
        if menuItem.title == "Frame Rate" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "frameRate")) }
        if menuItem.title == "Genre" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "genre")) }
        if menuItem.title == "Height" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "height")) }
        if menuItem.title == "Play Count" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "playCount")) }
        if menuItem.title == "Run Time" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "runTime")) }
        if menuItem.title == "Size" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "size")) }
        if menuItem.title == "Title" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "title")) }
        if menuItem.title == "Video Media" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "videoMedia")) }
        if menuItem.title == "Width" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "width")) }
        if menuItem.title == "Year" { tableColumn = tableView.tableColumn(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "year")) }
        
        menuItem.state == .off ? () : ()
        if(menuItem.state == .off){
            tableColumn?.isHidden = true
            tableColumn?.width = 0
            tableColumn?.minWidth = 0
        }
        else{
            tableColumn?.isHidden = false
            tableColumn?.width = 50
            tableColumn?.minWidth = 10
        }
        

    }
    
}
