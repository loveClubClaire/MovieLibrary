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
        //Set a unique autosave name so the configuration of the colums persist over app launches
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
        else if identifier == "aspectRatio" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AspectRatioCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].aspectRatio ?? ""
        }
        else if identifier == "bitRate" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BitRateCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].bitrate ?? ""
        }
        else if identifier == "comments" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CommentsCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].comments ?? ""
        }
        else if identifier == "director" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DirectorCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].director ?? ""
        }
        else if identifier == "frameRate" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FrameRateCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].frameRate ?? ""
        }
        else if identifier == "genre" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GenreCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].genre ?? ""
        }
        else if identifier == "height" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeightCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].height ?? ""
        }
        else if identifier == "playCount" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PlayCountCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = String(movieData[row].playCount)
        }
        else if identifier == "runTime" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "RunTimeCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].runtime ?? ""
        }
        else if identifier == "size" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SizeCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].fileSize ?? ""
        }
        else if identifier == "videoMedia" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "VideoMediaCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].videoFormat ?? ""
        }
        else if identifier == "width" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "WidthCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = movieData[row].width ?? ""
        }
        else if identifier == "year" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "YearCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = (movieData[row].year != nil ?  String(movieData[row].year!) : "")
        }
        
    
        // return the populated NSTableCellView
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        //Convert the data array into an NSMutableArray, sort that using the given SortDescriptor, and then convert it back to an array. Then reload the data. We do this because array can not be sorted by SortDescriptor as of Swift 4 but NSMutableArray can.
        //For Swift 4, https://stackoverflow.com/a/44790231 talks about class requirments to comply with objective-c sortDescriptors
        let dataMutableArray = NSMutableArray(array: movieData)
        dataMutableArray.sort(using: tableView.sortDescriptors)
        movieData = dataMutableArray as AnyObject as! [Movie]
        tableView.reloadData()
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
        //The sender has to be a MenuItem because only MenuItems are bound to this action. So we cast because that's what we're expecting
        let menuItem = (sender as! NSMenuItem)
        //Flip the state of the selected menu item
        menuItem.state == .off ? (menuItem.state = .on) : (menuItem.state = .off)
        //Identify the tableColumn assoicated with the selected menu item
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
        //If the specific tableColumn is visible, we make it hidden and shrink it's size to 0. If it's hidden, we make it visible and give it a width and a minimum width
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
