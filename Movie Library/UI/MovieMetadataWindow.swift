//
//  MovieMetadataWindow.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/14/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class MovieMetadataWindow: NSObject {

    @IBOutlet weak var MetadataWindow: NSWindow!
    @IBOutlet weak var MetadataCustomView: NSView!
    @IBOutlet weak var DetailsView: NSView!
    @IBOutlet weak var ArtworkView: NSView!
    @IBOutlet weak var SegControl: NSSegmentedControl!
    
    
    
    func spawnMovieMetadataWindow(){
        //Code to round the edges of the Metadata Window
        //TODO, determine if you want this here or somehwere else 
        MetadataWindow.contentView?.wantsLayer = true;
        MetadataWindow.contentView?.layer?.cornerRadius = 5.0
        MetadataWindow.contentView?.layer?.backgroundColor = .white
        MetadataWindow.isOpaque = false
        MetadataWindow.backgroundColor = .clear
        MetadataWindow.titlebarAppearsTransparent = true
        MetadataWindow.titleVisibility = .hidden
        
    }
    
    
    @IBAction func SegmentSelection(_ sender: Any) {
        MetadataCustomView.subviews = []
        if SegControl.selectedSegment == 0 {
            MetadataCustomView.addSubview(DetailsView)
        }
        else if SegControl.selectedSegment == 1{
            MetadataCustomView.addSubview(ArtworkView)
        }
        else{
            
        }
        
    }
    
    
    
}