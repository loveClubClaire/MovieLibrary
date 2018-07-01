//
//  Hash.swift
//  Movie Library
//
//  Created by Zachary Whitten on 6/30/18.
//  Copyright © 2018 16^2. All rights reserved.
//
//Hash function taken from https://stackoverflow.com/a/32166735
//Used for unique identification for for security so the effectiveness is untested

import Cocoa

class Hash: NSObject {

    static func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }

    
}
