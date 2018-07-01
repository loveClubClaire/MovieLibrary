//
//  SidebarViewController.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/23/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class SidebarOutlineView: NSOutlineView, NSOutlineViewDataSource, NSOutlineViewDelegate {

    @IBOutlet weak var MovieDisplayObject: MovieDisplay!
    
    let groups = ["Library", "Playlists"]
    let libItems = [SidebarMenuItem(name: "Movies", contents: []),SidebarMenuItem(name: "Recently Added", contents: [])]
    var playlistItems : [SidebarMenuItem] = []
    
    
    func viewDidLoad() {
        // Do view setup here.
        self.dataSource = self
        self.delegate = self
        self.expandItem(nil, expandChildren: true)
        //Registers the pasteboard types that the view will accept as the destination of an image-dragging session.
        self.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: "movie.data"),NSPasteboard.PasteboardType(rawValue: "sidebar.data")])
        //Programatically selecting a default row
        self.selectRowIndexes(IndexSet.init(integer: 1), byExtendingSelection: false)
    }
    
    //Updates the MovieDisplay data source to contain only the items in the selected sidebar row
    //Function should have a O(n log n)
    func updateMovieDisplayDataSource(){
        //Get the selected sidebarrow
        let selectedRow = self.selectedRow
        //Index 0 is a group (the library group) which can not be selected. So if the selected row is between 1 and libItems.count, the the selected row is in the Library group and resides in the libItems array
        if selectedRow >= 1 && selectedRow < libItems.count{
            //All items in the Library group display all movies, so we get all of the values from the movieData dictionary and place them in an array. We then make that array the datasource for the MovieDisplayObject and reload the tableview
            let arrayFromMovieData = Array(MovieDisplayObject.movieData.values.map{$0})
            MovieDisplayObject.currentData = arrayFromMovieData
            MovieDisplayObject.tableView.reloadData()
            
        }
        //If the selectedRow is greater than libItems.count, we know the selectedRow isn't in the Library group. Checking if its less than the sum of all three sidebar row arrays is a bounds check, which shouldn't ever fail.
        else if selectedRow > libItems.count && selectedRow < (playlistItems.count + groups.count + libItems.count){
            var arrayFromMovieData : [Movie] = []
            //Iterate over every uniqueID stored in the selected row. We know we're in the playlist group, so we get the contents of the playlist from the playlistItems array and do some subtraction to convert the selected row into the coresponding playlistItem index.
            //For each uniqueID in a playlist, we get the assoicated Movie object from the movieData library and appened it to an array
            for uniqueID in playlistItems[selectedRow-groups.count-libItems.count].contents{
                if let movieObject = MovieDisplayObject.movieData[uniqueID]{
                    arrayFromMovieData.append(movieObject)
                }
            }
            //With the generated array of movie items, we make it the current data array and then reload the table view.
            MovieDisplayObject.currentData = arrayFromMovieData
            MovieDisplayObject.tableView.reloadData()
        }
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
            return libItems[index].name
        }
        else if item as? String == groups[1]{
            return playlistItems[index].name
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
    
    //Drag and drop methods
    //Returns an NSPasteboardItem with the selected data to be dragged and dropped somewhere else
    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
        return NSPasteboardItem()
    }
    
    //Determines if the currently dragged rows can be dropped in a specific location. Returns a NSDragOperation to indicate if items can be dragged to the specific location
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        //The index parameter represents where we are attempting to drop our dragged items. It is NOT the index of the NSOutlineView, rather it indicates if we are dropping between items, on top of items, or something else of that nature. More like an enum than an index.
        //An index of -1 indicates we are attempting to drop onto an existing item
        //If we are attempting to drop onto an existing item and that item isn't one of the group indicators and the item isn't null, then we return an NSDrag operation allowing us do the drop. Otherwise we return an empty array which prevents the drop
        if(index == -1 && item as? String != groups[0] && item as? String != groups[1] && item != nil){
            return NSDragOperation.move
        }
        else{
            return []
        }
        
        
    }
    
    //Is called after a drop takes placed. Used to update all necessary data structures
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
 
        //If the sidebar is receiving movie data
        if((info.draggingPasteboard().types![0]).rawValue == "movie.data"){
            //Get the raw data from the given pasteboard assoicated with the movie.data pasteboard type and convert that data to a Swift object
            //The data will unarchive into an NSIndexSet
            let selectedMovies = NSKeyedUnarchiver.unarchiveObject(with: info.draggingPasteboard().data(forType: NSPasteboard.PasteboardType(rawValue: "movie.data"))!)
            let droppedRowIndex = self.row(forItem: item)
            //For every selected index in the MovieDisplayTableView, get the uniqueID of the movie item and append it to the playlist where the selected items are being dropped
            for index in selectedMovies as! NSIndexSet{
               playlistItems[droppedRowIndex-groups.count-libItems.count].contents.append(MovieDisplayObject.currentData[index].uniqueID)
            }
        }
        
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        NSKeyedArchiver.archiveRootObject(self.playlistItems, toFile: appDelegate.storedPlaylistsFilepath)
        return true
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
    
    //Called when a new row is being selected
    func outlineViewSelectionIsChanging(_ notification: Notification) {
        updateMovieDisplayDataSource()
    }

}
