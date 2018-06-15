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
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MovieDisplayObject.viewDidLoad()
        MetadataWindow.spawnMovieMetadataWindow()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func addMovieMenuItemSelected(_ sender: Any) {
        if let newMovie = MenuBar.addMovie(){
            MovieDisplayObject.movieData.append(newMovie)
            MovieDisplayObject.tableView.reloadData()
        }
    }

}

