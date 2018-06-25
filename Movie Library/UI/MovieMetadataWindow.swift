//
//  MovieMetadataWindow.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/14/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class MovieMetadataWindow: NSWindow {

    @IBOutlet weak var MovieDisplayObject: MovieDisplay!
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
    //Image View
    @IBOutlet weak var movieArtImageView: DragDropImageView!
    //File View
    @IBOutlet weak var kindLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var bitRateLabel: NSTextField!
    @IBOutlet weak var dateModifiedLabel: NSTextField!
    @IBOutlet weak var dateAddedLabel: NSTextField!
    @IBOutlet weak var locationLabel: NSTextField!
    @IBOutlet weak var heightLabel: NSTextField!
    @IBOutlet weak var widthLabel: NSTextField!
    @IBOutlet weak var frameRateLabel: NSTextField!
    @IBOutlet weak var aspectRatioLabel: NSTextField!
    
    
    func spawnMovieMetadataWindow(){
        //Configures the window so that it's edges are rounded. To change the intensity of the curve, modify the cornerRadius property 
        self.contentView?.wantsLayer = true;
        self.contentView?.layer?.cornerRadius = 5.0
        self.contentView?.layer?.backgroundColor = .white
        self.isOpaque = false
        self.backgroundColor = .clear
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden
        //Configures a default view
        MetadataCustomView.subviews = []
        SegControl.selectedSegment = 0
        MetadataCustomView.addSubview(DetailsView)
        //Gets the movie object selected in the TableView
        let aMovie = MovieDisplayObject.movieData[MovieDisplayObject.tableView.selectedRow]
        
        //Places the values from the selected movie onto the various views
        //Details View
        titleTextField.stringValue = aMovie.title ?? ""
        directorTextField.stringValue = aMovie.director ?? ""
        genereTextField.stringValue = aMovie.genre ?? ""
        yearTextField.stringValue = aMovie.year == nil ? "" : String(aMovie.year!)
        runTimeLabel.stringValue = aMovie.runtime ?? ""
        playCountLabel.stringValue = String(aMovie.playCount) + (aMovie.lastPlayed == nil ? "" : (aMovie.lastPlayed?.description)!)
        commentsTextField.stringValue = aMovie.comments ?? ""
        //Artwork View
        movieArtImageView.image = aMovie.movieArt
        //File View
        kindLabel.stringValue = aMovie.videoFormat ?? ""
        sizeLabel.stringValue = aMovie.fileSize ?? ""
        bitRateLabel.stringValue = aMovie.bitrate ?? ""
        locationLabel.stringValue = aMovie.filepath?.absoluteString.removingPercentEncoding ?? ""
        heightLabel.stringValue = aMovie.height ?? ""
        widthLabel.stringValue = aMovie.width ?? ""
        frameRateLabel.stringValue = aMovie.frameRate ?? ""
        aspectRatioLabel.stringValue = aMovie.aspectRatio ?? ""
        
        
        //Make window centered, visible / focused, and makes app only respond to actions assoicated with that window
        NSApp.runModal(for: self)
    }
    
    override func mouseDown(with event: NSEvent) {
        movieArtImageView.select = false
        movieArtImageView.highlight = false
        movieArtImageView.needsDisplay = true
    }
    
    override func keyDown(with anEvent: NSEvent) {
        //Else if the delete key (key code 51) is pressed call the delete function
        if(anEvent.keyCode == 51){
            movieArtImageView.select = false
            movieArtImageView.highlight = false
            movieArtImageView.image = nil
            movieArtImageView.needsDisplay = true
        }
            //Else just do what would have been expected
        else{
            super.keyDown(with: anEvent)
        }
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
        aMovie.year = yearTextField.stringValue
        aMovie.comments = commentsTextField.stringValue
        aMovie.movieArt = movieArtImageView.image
        
        //Save the updated data
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        NSKeyedArchiver.archiveRootObject(MovieDisplayObject.movieData, toFile: appDelegate.storedMoviesFilepath)
        
        //Reload MovieDisplay Table View
        MovieDisplayObject.tableView.reloadData()
        
        //StopModal and orderout window
        NSApp.stopModal()
        self.orderOut(self)
    }

    @IBAction func CancelButtonPressed(_ sender: Any) {
        //StopModal and orderout window
        NSApp.stopModal()
        self.orderOut(self)
    }
    
    
}
