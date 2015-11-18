//
//  favouriteViewController.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 18/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import UIKit
import CoreData

class favouriteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var movie = [NSManagedObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidAppear(animated: Bool) {
        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    func fetchData(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Media")
        
        let error = NSErrorPointer()
        let results = managedContext?.executeFetchRequest(fetchRequest, error: error)
        movie = results as! [NSManagedObject]
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let logItemToDelete = movie[indexPath.row]
            
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(logItemToDelete)
            // Refresh the table view to indicate that it's deleted
            self.fetchData()
            // Tell the table view to animate out that row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return movie.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("favouriteCell") as! favouriteCell
            
            let temp = movie[indexPath.row]
            
            cell.name.text =
                temp.valueForKey("name") as? String
            
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}