//
//  MovieMetadataWindow.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/14/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class MovieMetadataWindow: NSObject {

    @IBOutlet weak var MovieDisplayObject: MovieDisplay!
    @IBOutlet weak var MetadataWindow: NSWindow!
    @IBOutlet weak var MetadataCustomView: NSView!
    @IBOutlet weak var DetailsView: NSView!
    @IBOutlet weak var ArtworkView: NSView!
    @IBOutlet weak var FileView: NSView!
    @IBOutlet weak var SegControl: NSSegmentedControl!
    
    
    
    //View Components
    //Details View
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var directorTextField: NSTextField!
    @IBOutlet weak var genereTextField: NSTextField!
    @IBOutlet weak var yearTextField: NSTextField!
    @IBOutlet weak var runTimeLabel: NSTextField!
    @IBOutlet weak var playCountLabel: NSTextField!
    @IBOutlet weak var commentsTextField: NSTextField!
    @IBOutlet weak var movieArtImageView: DragDropImageView!
        
    func spawnMovieMetadataWindow(){
        //Configures the window so that it's edges are rounded. To change the intensity of the curve, modify the cornerRadius property 
        MetadataWindow.contentView?.wantsLayer = true;
        MetadataWindow.contentView?.layer?.cornerRadius = 5.0
        MetadataWindow.contentView?.layer?.backgroundColor = .white
        MetadataWindow.isOpaque = false
        MetadataWindow.backgroundColor = .clear
        MetadataWindow.titlebarAppearsTransparent = true
        MetadataWindow.titleVisibility = .hidden
        //Configures a default view
        MetadataCustomView.subviews = []
        SegControl.selectedSegment = 0
        MetadataCustomView.addSubview(DetailsView)
        //Gets the movie object selected in the TableView
        let aMovie = MovieDisplayObject.movieData[MovieDisplayObject.tableView.selectedRow]
        
        //Places the values from the selected movie onto the various views
        titleTextField.stringValue = aMovie.title ?? ""
        directorTextField.stringValue = aMovie.director ?? ""
        genereTextField.stringValue = aMovie.genre ?? ""
        yearTextField.stringValue = aMovie.year == nil ? "" : String(aMovie.year!)
        runTimeLabel.stringValue = ""
        playCountLabel.stringValue = String(aMovie.playCount) + (aMovie.lastPlayed == nil ? "" : (aMovie.lastPlayed?.description)!)
        commentsTextField.stringValue = aMovie.comments ?? ""
        movieArtImageView.image = aMovie.movieArt
        
        //Make window centered, visible / focused, and makes app only respond to actions assoicated with that window
        NSApp.runModal(for: MetadataWindow)
    }
    
    
    @IBAction func SegmentSelection(_ sender: Any) {
        MetadataCustomView.subviews = []
        if SegControl.selectedSegment == 0 {
            MetadataCustomView.addSubview(DetailsView)
        }
        else if SegControl.selectedSegment == 1{
            MetadataCustomView.addSubview(ArtworkView)
        }
        else if SegControl.selectedSegment == 2{
            MetadataCustomView.addSubview(FileView)
        }
    }
    
    @IBAction func OkButtonPressed(_ sender: Any) {
        //Store values
        let aMovie = MovieDisplayObject.movieData[MovieDisplayObject.tableView.selectedRow]
        aMovie.title = titleTextField.stringValue
        aMovie.director = directorTextField.stringValue
        aMovie.genre = genereTextField.stringValue
        aMovie.year = yearTextField.stringValue == "" ? nil : Int(yearTextField.stringValue)
        //TODO runTimeLabel.stringValue
        aMovie.comments = commentsTextField.stringValue
        aMovie.movieArt = movieArtImageView.image
        
        //Save the updated data
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        NSKeyedArchiver.archiveRootObject(MovieDisplayObject.movieData, toFile: appDelegate.storedMoviesFilepath)
        //StopModal and orderout window
        NSApp.stopModal()
        MetadataWindow.orderOut(self)
    }

    @IBAction func CancelButtonPressed(_ sender: Any) {
        //StopModal and orderout window
        NSApp.stopModal()
        MetadataWindow.orderOut(self)
    }
    
    
}
