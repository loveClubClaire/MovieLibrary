//
//  MenuBar.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/13/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa
import MediaInfoKit

class MenuBar: NSObject {
    
    static func addMovie() -> [Movie]{
        var newMovies: [Movie] = []
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["3gp","asf","wmv","au","avi","flv","mov","mp4","ogm","ogg","mkv","mka","ts","mpg","mpg","mp3","mp2","nsc","nsv","nut","a52","dts","aac","flac","dv","vid","tta","tac","ty","wav","dts","xa","m4v"]
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        let result = openPanel.runModal()
        if result == NSApplication.ModalResponse.OK {
            for aURL in openPanel.urls{
                let newMovie = Movie(aTitle: aURL.lastPathComponent, aFilepath: aURL)
                //Generate metadata analysis and store selected results in new movie object
                guard let info = MIKMediaInfo(fileURL: aURL) else {
                    fatalError("The movie is not readable by mediainfolib.")
                }
                newMovie.runtime = info.value(forKey: "Duration", streamKey: "General")
                newMovie.fileSize = info.value(forKey: "File size", streamKey: "General")
                newMovie.bitrate = info.value(forKey: "Overall bit rate", streamKey: "General")
                newMovie.videoFormat = info.value(forKey: "Format", streamKey: "General")
                newMovie.height = info.value(forKey: "Height", streamKey: "Video")
                newMovie.width = info.value(forKey: "Width", streamKey: "Video")
                newMovie.frameRate = info.value(forKey: "Frame Rate", streamKey: "Video")
                newMovie.aspectRatio = info.value(forKey: "Display aspect ratio", streamKey: "Video")

                newMovies.append(newMovie)
            }
        }
        return newMovies
    }
    
    
    
}
