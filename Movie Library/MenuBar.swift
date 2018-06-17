//
//  MenuBar.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/13/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class MenuBar: NSObject {
    
    static func addMovie() -> Movie?{
        var newMovie: Movie?
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["3gp","asf","wmv","au","avi","flv","mov","mp4","ogm","ogg","mkv","mka","ts","mpg","mpg","mp3","mp2","nsc","nsv","nut","a52","dts","aac","flac","dv","vid","tta","tac","ty","wav","dts","xa","m4v"]
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        let result = openPanel.runModal()
        if result == NSApplication.ModalResponse.OK {
            let filepath = openPanel.url!
            newMovie = Movie(aName: filepath.lastPathComponent, aFilepath: filepath)
        }
        return newMovie
    }
    
    
    
}
