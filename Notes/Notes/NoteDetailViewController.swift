//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Ross McIlwaine on 5/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UITextFieldDelegate {

    var note: Note?
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let note = note {
            updateWithNote(note)
        } else {
            self.navigationItem.title = "New Note"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if let note = self.note {
            
            note.entry = noteTextView.text
            note.timeStamp = NSDate()
        } else {
            
            let newNote = Note(entry: self.noteTextView.text)
            NoteController.sharedController.addNote(newNote)
            self.note = newNote
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func infoButtonTapped(sender: AnyObject) {
        infoAlert()
    }
    
    
    func updateWithNote(note: Note) {
        
        self.note = note
        
        noteTextView.text = note.entry
        
        self.navigationItem.title = note.entry
    }
    
    
    // MARK: UITextField Dismiss
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Action Alert
    func infoAlert() {
        
        let alertController = UIAlertController(title: "QUICK TIP", message: "To give Title's to notes, hit enter after first line :)", preferredStyle: .Alert)
        let addActionOk = UIAlertAction(title: "GOT IT", style: .Default, handler: nil)
        alertController.addAction(addActionOk)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
