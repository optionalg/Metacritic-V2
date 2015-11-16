//
//  criticReviewController.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 14/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import UIKit

class criticReviewController: UIViewController, searchServiceDelegate, UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var url: String?
    var type: String?
    var movieDetail: NSDictionary = NSDictionary()
    var reviewCellIdentifier = "reviewCell"
    var criticR = [criticReviews]()
    
    lazy var api: searchService = searchService(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(url)
        api.delegate = self
        api.searchMetacritic(url!, typeTerm:type!)
    }
    
    func didFinishSearch(results: NSDictionary) {
        //println(results)
        criticReviewsFromJSON(results["results"] as! NSArray)
        self.tableView.reloadData()
        //println(self.movieDetail)
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let CellIdentifier: String = "Cell"
        //        var cell : UITableViewCell?
        //        cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        //
        //        if cell == nil {
        //            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CellIdentifier)
        //        }
        //        var rowData: NSDictionary = self.tableData[indexPath.row] as! NSDictionary
        //        let cellText: String? = rowData["name"] as? String
        //        cell!.textLabel?.text = cellText
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reviewCellIdentifier) as! reviewCell
        setStringsForCell(cell, indexPath: indexPath)
        // Add detail text label
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.criticR.count
        
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  200.0
        
    }
    

        func criticReviewsFromJSON(results:NSArray){
            if results.count > 0{
                for result in results{
                    var critic = result["name"] as? String
                    var score = result["score"] as? String
                    var date = result["date"] as? String
                    var excerpt = result["review"] as? String
                    var newReview = criticReviews(critic: critic!, score : score!, date : date!, excerpt: excerpt!)
                    self.criticR.append(newReview)
                }
            }
        }
    
    func setStringsForCell(cell:reviewCell, indexPath: NSIndexPath){
        var temp = criticR[indexPath.row]
        //println(userR[indexPath.row].name)
        cell.criticLabel.text = temp.critic
        cell.reviewLabel.text = temp.excerpt
        cell.dateLabel.text = temp.date
        cell.scoreLabel.text = temp.score
    }
}