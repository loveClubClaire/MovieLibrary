//
//  AppDelegate.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/3/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var MovieDisplayObject: MovieDisplay!
    @IBOutlet weak var MetadataWindow: MovieMetadataWindow!
    @IBOutlet weak var SidebarView: SidebarOutlineView!
    
    @IBOutlet weak var window: NSWindow!

    
    var storedMoviesFilepath = ""
    var storedPlaylistsFilepath = ""

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //Get the filepaths of our applications stored data.
        //We grab the URL for the application support folder and append the application name to the end of it, giving us the filepath where all data is stored. If the app has been run before, we should have a valid URL, if not, we create the directory so that the URL is valid. We then create constants with individual file names appended to the stored data directory. If a file does not exist, it will be created using that filepath.
        let applicationSupportFilepath = try! FileManager().url(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        let storedDataFilepath = applicationSupportFilepath.path + "/Movie Library"
        if(FileManager().fileExists(atPath: storedDataFilepath) == false){
            try! FileManager().createDirectory(atPath: storedDataFilepath, withIntermediateDirectories:false, attributes: nil)
        }
        storedMoviesFilepath = storedDataFilepath + "/StoredMovies.txt"
        storedPlaylistsFilepath = storedDataFilepath + "/StoredPlaylists.txt"
        
        //Get the information stored in file at the storedMoviesFilepath. If its not empty (or non existant), set the data array to the reterived values and reload the tableview
        if let movies = NSKeyedUnarchiver.unarchiveObject(withFile: storedMoviesFilepath){
            MovieDisplayObject.movieData = movies as! [String : Movie]
            MovieDisplayObject.tableView.reloadData()
        }
        if let playlists = NSKeyedUnarchiver.unarchiveObject(withFile: storedPlaylistsFilepath){
            SidebarView.playlistItems = playlists as! [SidebarMenuItem]
        }
        
  
        
        SidebarView.viewDidLoad()
        MovieDisplayObject.viewDidLoad()
        SidebarView.updateMovieDisplayDataSource()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func addMovieMenuItemSelected(_ sender: Any) {
        let newMovies = MenuBar.addMovie()
        for newMovie in newMovies{
            MovieDisplayObject.movieData[newMovie.uniqueID] = newMovie
        }
        NSKeyedArchiver.archiveRootObject(MovieDisplayObject.movieData, toFile: storedMoviesFilepath)
        //Select the "Library" row on the sidebar whenever new items are added
        SidebarView.selectRowIndexes(IndexSet.init(integer: 1), byExtendingSelection: false)
        SidebarView.updateMovieDisplayDataSource()
        MovieDisplayObject.tableView.reloadData()
    }
    
    @IBAction func deleteMovieMenuItemSelected(_ sender: Any) {
        
         //Index 0 is a group (the library group) which can not be selected. So if the selected row is between 1 and libItems.count, the the selected row is in the Library group and resides in the libItems array
        if SidebarView.selectedRow >= 1 && SidebarView.selectedRow < SidebarView.libItems.count{
            MovieDisplayObject.tableView.selectedRowIndexes.reversed().forEach{
                let removedItem = MovieDisplayObject.currentData.remove(at: $0)
                MovieDisplayObject.movieData.removeValue(forKey: removedItem.uniqueID)
            }
            NSKeyedArchiver.archiveRootObject(MovieDisplayObject.movieData, toFile: storedMoviesFilepath)
        }
        //If the selectedRow is greater than libItems.count, we know the selectedRow isn't in the Library group.
        else{
            MovieDisplayObject.tableView.selectedRowIndexes.reversed().forEach{
                SidebarView.playlistItems[SidebarView.selectedRow-SidebarView.groups.count-SidebarView.libItems.count].contents.remove(at: $0)
                MovieDisplayObject.currentData.remove(at: $0)
            }
             NSKeyedArchiver.archiveRootObject(SidebarView.playlistItems, toFile: storedPlaylistsFilepath)
        }
        
        MovieDisplayObject.tableView.reloadData()
    }
    
    @IBAction func editMovieMenuItemSelected(_ sender: Any) {
        MetadataWindow.spawnMovieMetadataWindow()
    }
    
}

