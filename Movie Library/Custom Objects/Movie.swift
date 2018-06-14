//
//  Movie.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/13/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class Movie: NSObject, NSCoding {
    
    var name: String?
    var genre: String?
    var director: String?
    var year: Int?
    var notes: String?
    var movieArt: NSImage?
    var lastPlayed: NSDate?
    var filepath: URL?
    
    //Encoding fucntion for saving. Encode each object with a key for retervial
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(genre, forKey: "genre")
        coder.encode(director, forKey: "director")
        coder.encode(year, forKey: "year")
        coder.encode(notes, forKey: "notes")
        coder.encode(movieArt, forKey: "movieArt")
        coder.encode(lastPlayed, forKey: "lastPlayed")
        coder.encode(filepath, forKey: "filepath")
    }
    
    //Decode each individual object and then create a new object instance
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.genre = aDecoder.decodeObject(forKey: "genre") as? String
        self.director = aDecoder.decodeObject(forKey: "director") as? String
        self.year = aDecoder.decodeObject(forKey: "year") as? Int
        self.notes = aDecoder.decodeObject(forKey: "notes") as? String
        self.movieArt = aDecoder.decodeObject(forKey: "movieArt") as? NSImage
        self.lastPlayed = aDecoder.decodeObject(forKey: "lastPlayed") as? NSDate
        self.filepath = aDecoder.decodeObject(forKey: "filepath") as? URL
    }
    
    
    
    
}
