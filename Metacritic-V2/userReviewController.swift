//
//  userReviewController.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 12/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import UIKit

class userReviewController: UIViewController, searchServiceDelegate, UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var url: String?
    var type: String?
    var movieDetail: NSDictionary = NSDictionary()
    var reviewCellIdentifier = "reviewCell"
    var userR = [userReviews]()

    lazy var api: searchService = searchService(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(url)
        api.delegate = self
        api.searchMetacritic(url!, typeTerm:type!)
}
    
    func didFinishSearch(results: NSDictionary) {
        //println(results)
        userReviewsFromJSON(results["results"] as! NSArray)
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
        return self.userR.count
        
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return  200.0
        
    }
    
    func userReviewsFromJSON(results:NSArray){
        if results.count > 0{
            for result in results{
                var name = result["name"] as? String
                var score = result["score"] as? String
                var date = result["date"] as? String
                var review = result["review"] as? String
                var newReview = userReviews(name: name!, score : score!, date : date!, review: review!)
                self.userR.append(newReview)
            }
        }
    }
//    func criticReviewsFromJSON(results:NSArray){
//        if results.count > 0{
//            for result in results{
//                var critic = result["name"] as? String
//                var score = result["score"] as? String
//                var date = result["date"] as? String
//                var excerpt = result["review"] as? String
//                var newReview = criticReviews(critic: critic!, score : score!, date : date!, excerpt: excerpt!)
//                self.criticR.append(newReview)
//            }
//        }
//    }
    
    func setStringsForCell(cell:reviewCell, indexPath: NSIndexPath){
        var temp = userR[indexPath.row]
        //println(userR[indexPath.row].name)
        cell.criticLabel.text = temp.name
        cell.reviewLabel.text = temp.review
        cell.dateLabel.text = temp.date
        cell.scoreLabel.text = temp.score
    }
}