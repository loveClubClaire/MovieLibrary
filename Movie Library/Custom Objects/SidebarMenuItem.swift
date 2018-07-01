//
//  SidebarMenuItem.swift
//  Movie Library
//
//  Created by Zachary Whitten on 7/1/18.
//  Copyright © 2018 16^2. All rights reserved.
//

import Cocoa

class SidebarMenuItem: NSObject, NSCoding{
    
    var name: String
    var contents: [String]
    
    init(name: String, contents: [String]) {
        self.name = name
        self.contents = contents
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(contents, forKey: "contents")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.contents = aDecoder.decodeObject(forKey: "contents") as! [String]
    }
    

    
    
}
