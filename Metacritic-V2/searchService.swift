//
//  searchService.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 10/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation

protocol searchServiceDelegate{
    func didFinishSearch(results: NSDictionary)
}

class searchService{
    var delegate: searchServiceDelegate?
    
    init(delegate: searchServiceDelegate?){
        self.delegate = delegate
    }
    
    func searchMetacritic(searchTerm: String, typeTerm: String){
//        var urlString = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        println(urlString)
        var urlString = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        if let urlString = urlString{

        println(urlString)
        let urlText:String
        
        switch (typeTerm){
        case "movie":
            urlText = "https://metacritic-2.p.mashape.com/search/movie?max_pages=2&title=\(urlString)"
        case "game":
            urlText = "https://metacritic-2.p.mashape.com/search/games?title=\(urlString)"
        case "music":
            urlText = "https://metacritic-2.p.mashape.com/search/music?title=\(urlString)"
        case "movieDetail":
            urlText = "https://metacritic-2.p.mashape.com/find/movie?title=\(urlString)"
        case "gameDetail":
            urlText = "https://metacritic-2.p.mashape.com/find/games?title=\(urlString)"
        case "musicDetail":
            urlText = "https://metacritic-2.p.mashape.com/find/music?title=\(urlString)"
        case "criticReviews":
            urlText = "https://metacritic-2.p.mashape.com/reviews?url=\(urlString)"
        case "userReviews":
            urlText = "https://metacritic-2.p.mashape.com/user-reviews?url=\(urlString)"

        default:
            urlText = "https://metacritic-2.p.mashape.com/search/movie?title=\(urlString)"
        }
        println(urlText)
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
                    apiDelegate.didFinishSearch(jsonResult)
                }
            }
        }
        
        task.resume()
        }
    }
}