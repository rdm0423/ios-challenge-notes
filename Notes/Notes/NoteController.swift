//
//  NoteController.swift
//  Notes
//
//  Created by Ross McIlwaine on 5/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class NoteController {
    
    private let kNotes = "notes"
    
    static let sharedController = NoteController()
    
    var notes: [Note]
    
    init() {
        
        self.notes = []
        loadFromPersistentStorage()
    }
    
    func addNote(note: Note) {
        
        notes.append(note)
        saveToPersistentStorage()
    }
    
    func removeNote(note: Note) {
        
        if let noteIndex = notes.indexOf(note) {
            notes.removeAtIndex(noteIndex)
        }
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        
        let noteDictionary = self.notes.map{$0.dictionaryCopy}
        NSUserDefaults.standardUserDefaults().setObject(noteDictionary, forKey: kNotes)
    }
    
    func loadFromPersistentStorage() {
        
        guard let notesDictionaryArray = NSUserDefaults.standardUserDefaults().objectForKey(kNotes) as? [[String:AnyObject]] else {
            
            return
        }
        notes = notesDictionaryArray.flatMap{Note(dictionary: $0)}
    }
    
    
    
}