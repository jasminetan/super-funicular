//
//  EntriesViewController.swift
//  Travelogue
//
//  Created by Jasmine Tan on 5/7/20.
//  Copyright © 2020 Jasmine Tan. All rights reserved.
//

import UIKit
import CoreData

class EntriesViewController: UITableViewController {

    var trip : Trip?
    var entries : [Entry]?
    var dateFormatter = DateFormatter()
    
    @IBOutlet var entriesTableView: UITableView!
    @IBOutlet weak var addEntry: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
    }
    override func viewWillAppear(_ animated: Bool) {

        entriesTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        if let entry = trip?.entries?[indexPath.row]{
            cell.textLabel?.text = entry.entryName
        }
        return cell
    }
    

    @IBAction func addEntryPressed(_ sender: Any) {
        performSegue(withIdentifier: "newEntrySegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleEntryViewController
            else{
                print("returning early")
                return
        }
        
        if let selectedRow = self.entriesTableView.indexPathForSelectedRow?.row {
            destination.entry = trip?.entries?[selectedRow]
        }
        
        destination.trip = trip
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteEntry(at: indexPath)
        }
    }
    
    func deleteEntry(at indexPath: IndexPath){
        guard let entry = trip?.entries?[indexPath.row], let managedContext = entry.managedObjectContext else{
            return
        }
        managedContext.delete(entry)
        do{
            try managedContext.save()
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Entry could not be deleted")
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    
        
    }
    
}
