//
//  NoteTableViewController.swift
//  Notes
//
//  Created by Ross McIlwaine on 5/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, CustomSearchControllerDelegate {

    var noteArray = [String]() // ***************** NEED TO ACCESS MY NOTE DATA
    var filteredNoteArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomerSearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // configure
//        configureSearchController()
        configureCustomSearchController()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    // MARK: Search Controller Setup
    
    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // dim background while searching??
        searchController.dimsBackgroundDuringPresentation = true
        
        // placeholder text
        searchController.searchBar.placeholder = "Search notes here..."
        
        // delegate
        searchController.searchBar.delegate = self
        
        // proper size
        searchController.searchBar.sizeToFit()
        
        // display searach bar to tableview
        tableView.tableHeaderView = searchController.searchBar
    }
    
    // MARK: Custom SearchBar
    func configureCustomSearchController() {
        customSearchController = CustomerSearchViewController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.lightGrayColor(), searchBarTintColor: UIColor.blackColor())
        
        customSearchController.customSearchBar.placeholder = "Search Notes..."
        tableView.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        // makes the filteredArary the datasource when searching begins
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // makes the standard data source again when cancels
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else {
            return
        }
        // filter the dataArray and get only those countries that match the search text
        filteredNoteArray = noteArray.filter({ (note) -> Bool in
            let noteText:NSString = note
            return (noteText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        // reload the tableview
        tableView.reloadData()
    }
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredNoteArray = noteArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            
            return (countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowSearchResults {
            return filteredNoteArray.count
        } else {
            return noteArray.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath)
        
        let note = NoteController.sharedController.notes[indexPath.row]
        
        // Format Date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let convertedDate = dateFormatter.stringFromDate(note.timeStamp)
//        cell.textLabel?.text = note.entry
        
        // Search Check Logic
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredNoteArray[indexPath.row]
            cell.detailTextLabel?.text = convertedDate
        } else {
            cell.textLabel?.text = noteArray[indexPath.row]
        }

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let note = NoteController.sharedController.notes[indexPath.row]
            NoteController.sharedController.removeNote(note)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "viewNoteSegue" {
            
            
            let detailViewController = segue.destinationViewController as? NoteDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let note = NoteController.sharedController.notes[indexPath.row]
                detailViewController?.note = note
            }
        }
    }
}
