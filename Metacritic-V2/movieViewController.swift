//
//  movieViewController.swift
//  Metacritic - V2
//
//  Created by Ajay Raj on 10/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//


import UIKit

class movieViewController: UIViewController,searchServiceDelegate, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    let movieCellIdentifier = "movieCell"
    
    lazy var api: searchService = searchService(delegate: self)
    var movieArray = [sMovie]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.delegate = self
        api.searchMetacritic("underworld",typeTerm: "movie")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didFinishSearch(results: NSDictionary) {
        movieSearchFromJSON(results["results"]as!  NSArray)
        self.tableView.reloadData()

        
    }
    func movieSearchFromJSON(results:NSArray){
        movieArray.removeAll()
        if results.count > 0 {
            for result in results{
                var name = result["name"] as? String
                var url = result["url"] as? String
                var rlsDate = result["rlsdate"] as? String
                var score = result["score"] as? String
                var summary = result["summary"] as? String
                var rating = result["rating"] as? String
                var cast = result["cast"] as? String
                var genre = result["genre"] as? String
                var avguserScore = result["avguserscore"] as? String
                var runtime = result["runtime"] as? String
                var newSearchMovie = sMovie(name: name!, url: url!, rlsDate: rlsDate!, score: score!, summary: summary!, rating: rating!, cast: cast!, genre: genre!, avgUserScore: avguserScore!, runtime: runtime!)
                movieArray.append(newSearchMovie)
                

            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(movieCellIdentifier) as! movieCell
        setStringsForCell(cell, indexPath: indexPath)
        // Add detail text label
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieArray.count
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var text: String = searchBar.text
        api.searchMetacritic(text, typeTerm: "movie")
        searchBar.resignFirstResponder()
    }
    
    func setStringsForCell(cell:movieCell, indexPath: NSIndexPath){
        var temp = movieArray[indexPath.row]
        cell.titleLabel.text = temp.name
        cell.subtitleLabel.text = temp.genre
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showMovieDetails") {
            var indexPath = tableView.indexPathForSelectedRow()
            var temp = self.movieArray[indexPath!.row]

            
            var detailViewController = segue.destinationViewController as! movieDetailController
            detailViewController.title = temp.name
            detailViewController.tempMovie = temp
        }
    }
    
}



