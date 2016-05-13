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

        // set title of detail to be first ... characters of the note
        
        if let note = note {
            
            updateWithNote(note)
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
