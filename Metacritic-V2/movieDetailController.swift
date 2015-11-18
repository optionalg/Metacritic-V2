//
//  movieDetailController.swift
//  Metacritic
//
//  Created by Ajay Raj on 10/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//


import UIKit


class movieDetailController: UIViewController, searchServiceDelegate, trailerAPIServiceDelegate {
    
    
    @IBOutlet weak var imgView: UIImageView!
    var filmTitle: String?
    var movieDetail: NSDictionary = NSDictionary()
    lazy var api: searchService = searchService(delegate: self)
    lazy var trailerAPI : trailerAPIService = trailerAPIService(delegate: self)
    
    // CONSTS
    struct reviewType{
        static let critics: String = "criticReviews"
        static let users: String = "userReviews"
    }
    
    //
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(filmTitle)
        api.delegate = self
        api.searchMetacritic(filmTitle!, typeTerm: "movieDetail")
        trailerAPI.delegate = self
        trailerAPI.searchTrailerApi(filmTitle!)
        //imageFromPath(self.movieDetail["thumbnail"] as! String)
    }
    
    func imageFromPath(path: String) {
        let posterURL = NSURL(string: path)
        let posterImageData = NSData(contentsOfURL: posterURL!)
        imgView.clipsToBounds = true
        imgView.image = UIImage(data: posterImageData!)
        
    }
    
    func didFinishTrailer(results: NSString){
        println(results)
        //moviesType.name = results["result"]
    }
    
    func didFinishSearch(results: NSDictionary) {
        // <-- PUT TRY CATCH
        self.movieDetail = results["result"] as! NSDictionary
        //println(self.movieDetail)
        imageFromPath(self.movieDetail["thumbnail"] as! String)
       //println(self.movieDetail["genre"] as! String)
//        println(self.movieDetail["genre"] as! String)
        //var testObject : Media = Media(data:self.movieDetail)
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var url = self.movieDetail["url"] as! String
        
        if (segue.identifier == "showUserReviews") {
            //println(url)
            var userReviewViewController = segue.destinationViewController as! userReviewController
            userReviewViewController.url = url
            userReviewViewController.type = reviewType.users
        } else if (segue.identifier == "showCriticReviews"){
            var criticReviewViewController = segue.destinationViewController as! criticReviewController
            criticReviewViewController.url  = url
            criticReviewViewController.type = reviewType.critics
        }
    }
}