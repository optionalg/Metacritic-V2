//
//  reviewService.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 12/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation

protocol reviewServiceDelegate{
    func didFinishReviewSearch(results: NSDictionary)
}

class reviewService{
    var delegate: reviewServiceDelegate?
    
    init(delegate: reviewServiceDelegate?){
        self.delegate = delegate
    }
    
    func searchReviews(searchTerm: String){
        var urlString = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //println(urlString)
        let urlText:String = "https://metacritic-2.p.mashape.com/reviews?url=\(urlString)"
        let urlPath = NSURL(string: urlText)
        var request = NSMutableURLRequest(URL: urlPath!)
        request.addValue("jNtsaTBi5smshkACF4nrD6OVSt2Xp1G9ErQjsnSBbrqEgGvyjN", forHTTPHeaderField: "X-Mashape-Key")
        
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request){data, response,error -> Void in
            if (error != nil){
                print(error.localizedDescription)
            }
            var jsonError : NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as! NSDictionary
            if ((jsonError) != nil){
                print(jsonError?.localizedDescription)
            }
            
            if let apiDelegate = self.delegate {
                dispatch_async(dispatch_get_main_queue()){
                    apiDelegate.didFinishReviewSearch(jsonResult)
                }
            }
        }
        task.resume()
    }
}