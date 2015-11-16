//
//  trailerAPIService.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 10/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//
import Foundation
protocol trailerAPIServiceDelegate{
    func didFinishTrailer(results: NSString)
}

class trailerAPIService{
    var delegate: trailerAPIServiceDelegate?
    
    init(delegate: trailerAPIServiceDelegate?){
        self.delegate = delegate
    }
    
    func searchTrailerApi(searchTerm: String){
        var urlString = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //println(urlString)
        
        let urlPath = NSURL(string: "http://trailersapi.com/trailers.json?movie=\(urlString!)&limit=1&width=320")
        var request = NSMutableURLRequest(URL: urlPath!)
        
        
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request){data, response,error -> Void in
            if (error != nil){
                print(error.localizedDescription)
            }
            var jsonError : NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as? NSArray
            if ((jsonError) != nil){
                print(jsonError?.localizedDescription)
            }
            println(jsonResult!.count)
            var code : String = jsonResult![0]["code"] as! String
            
            println(code)
            //var fst : Int? = code.indexOfCharacter("-") as Int?
            let tmp : NSString = code as NSString
            code = tmp.substringWithRange(NSRange(location: 67, length: 11))
            if let apiDelegate = self.delegate {
                apiDelegate.didFinishTrailer(code)
                
            }
        }   
        task.resume()
    }
}