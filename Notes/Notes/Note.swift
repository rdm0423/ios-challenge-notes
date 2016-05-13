//
//  Note.swift
//  Notes
//
//  Created by Ross McIlwaine on 5/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Note: Equatable {
    
    private let kEntry = "entryKey"
    private let kTimeStamp = "timeStampKey"
    
    // Define Properties
    var entry: String
    var timeStamp: NSDate
    
    // Computed Property
    var dictionaryCopy: [String:AnyObject] {
        
        return [kEntry: entry, kTimeStamp: timeStamp]
    }
    
    // Initialize
    init(entry: String, timeStamp: NSDate = NSDate()) {
        
        self.entry = entry
        self.timeStamp = timeStamp
    }
    
    // initialize dictionary
    init?(dictionary: [String:AnyObject]) {
        
        guard let entry = dictionary[kEntry] as? String,
        timeStamp = dictionary[kTimeStamp] as? NSDate else {
            
            self.entry = ""
            self.timeStamp = NSDate()
            
            return
        }
        self.entry = entry
        self.timeStamp = timeStamp
    }
}

// equatable
func ==(lhs: Note, rhs: Note) -> Bool {
    
    return lhs.entry == rhs.entry && lhs.timeStamp == rhs.timeStamp
}