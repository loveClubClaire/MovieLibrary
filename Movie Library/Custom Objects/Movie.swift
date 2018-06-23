//
//  Movie.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/13/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

@objcMembers
class Movie: NSObject, NSCoding {
    
    var title: String?
    var genre: String?
    var director: String?
    var year: String?
    var comments: String?
    var movieArt: NSImage?
    var lastPlayed: NSDate?
    var playCount: Int
    var filepath: URL?
    var runtime: String?
    var fileSize: String?
    var videoFormat: String?
    var bitrate: String?
    var height: String?
    var width: String?
    var frameRate: String?
    var aspectRatio: String?

    
    init(aTitle: String, aFilepath: URL) {
        title = aTitle
        filepath = aFilepath
        playCount = 0
    }
    
    //Encoding fucntion for saving. Encode each object with a key for retervial
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(genre, forKey: "genre")
        coder.encode(director, forKey: "director")
        coder.encode(year, forKey: "year")
        coder.encode(comments, forKey: "comments")
        coder.encode(movieArt, forKey: "movieArt")
        coder.encode(lastPlayed, forKey: "lastPlayed")
        coder.encode(playCount, forKey: "playCount")
        coder.encode(filepath, forKey: "filepath")
        coder.encode(runtime, forKey: "runtime")
        coder.encode(fileSize, forKey: "fileSize")
        coder.encode(videoFormat, forKey: "videoFormat")
        coder.encode(bitrate, forKey: "bitrate")
        coder.encode(height, forKey: "height")
        coder.encode(width, forKey: "width")
        coder.encode(frameRate, forKey: "frameRate")
        coder.encode(aspectRatio, forKey: "aspectRatio")
    }
    
    //Decode each individual object and then create a new object instance
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.genre = aDecoder.decodeObject(forKey: "genre") as? String
        self.director = aDecoder.decodeObject(forKey: "director") as? String
        self.year = aDecoder.decodeObject(forKey: "year") as? String
        self.comments = aDecoder.decodeObject(forKey: "comments") as? String
        self.movieArt = aDecoder.decodeObject(forKey: "movieArt") as? NSImage
        self.lastPlayed = aDecoder.decodeObject(forKey: "lastPlayed") as? NSDate
        self.playCount = aDecoder.decodeObject(forKey: "playCount") as? Int ?? 0
        self.filepath = aDecoder.decodeObject(forKey: "filepath") as? URL
        self.runtime = aDecoder.decodeObject(forKey: "runtime") as? String
        self.fileSize = aDecoder.decodeObject(forKey: "fileSize") as? String
        self.videoFormat = aDecoder.decodeObject(forKey: "videoFormat") as? String
        self.bitrate = aDecoder.decodeObject(forKey: "bitrate") as? String
        self.height = aDecoder.decodeObject(forKey: "height") as? String
        self.width = aDecoder.decodeObject(forKey: "width") as? String
        self.frameRate = aDecoder.decodeObject(forKey: "frameRate") as? String
        self.aspectRatio = aDecoder.decodeObject(forKey: "aspectRatio") as? String
    }
    
    
    
    
}
