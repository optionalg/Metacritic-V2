//
//  movieDetailController.swift
//  Metacritic
//
//  Created by Ajay Raj on 10/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//


import UIKit
import CoreData

class movieDetailController: UIViewController, searchServiceDelegate, trailerAPIServiceDelegate {
    
    
    @IBOutlet weak var imgView: UIImageView!
    var movieDetail: NSDictionary = NSDictionary()
    lazy var api: searchService = searchService(delegate: self)
    lazy var trailerAPI : trailerAPIService = trailerAPIService(delegate: self)
    
    var tempMovie = sMovie()
    var movieScore : NSNumber =  0
    // CONSTS
    struct reviewType{
        static let critics: String = "criticReviews"
        static let users: String = "userReviews"
    }
    
    //
    
    
    // CORE DATA
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    @IBAction func addMovie(sender: AnyObject) {
     ///// - move in method
        
        let alertController = UIAlertController(title: tempMovie.name, message: "Please Rate the film", preferredStyle: .Alert)
        let buttonOne = UIAlertAction(title:"Excellent",style: .Default, handler:{ (action) -> Void in
        self.coreDataAdd(5)
        })
        let buttonTwo = UIAlertAction(title:"Good",style: .Default, handler:{ (action) -> Void in
            self.coreDataAdd(4)
        })
        let buttonThree = UIAlertAction(title:"Average",style: .Default, handler:{ (action) -> Void in
            self.coreDataAdd(3)
        })
        let buttonFour = UIAlertAction(title:"Bad",style: .Default, handler:{ (action) -> Void in
            self.coreDataAdd(2)
        })
        let buttonFive = UIAlertAction(title:"Terrible",style: .Default, handler:{ (action) -> Void in
            self.coreDataAdd(1)
        })
        let buttonCancel = UIAlertAction(title:"Cancel",style: .Default, handler:{ (action) -> Void in
            return
        })
        alertController.addAction(buttonOne)
        alertController.addAction(buttonTwo)
        alertController.addAction(buttonThree)
        alertController.addAction(buttonFour)
        alertController.addAction(buttonFive)
        alertController.addAction(buttonCancel)
        
        presentViewController(alertController, animated:true, completion: nil)
    /////
        
//        let movie = Movie(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
//        //let movie = NSEntityDescription.insertNewObjectForEntityForName("Movie", inManagedObjectContext: self.managedObjectContext!) as! Movie
//        movie.name = tempMovie.name
//        movie.score = tempMovie.score
//        movie.genre = tempMovie.genre
//        movie.thumbnail = self.movieDetail["thumbnail"] as! String
//        movie.userScore = "1.2"
//        movie.summary = tempMovie.summary
//        movie.runtime = tempMovie.runtime
//        movie.director = self.movieDetail["director"] as! String
//        movie.cast = tempMovie.cast
//        movie.rating = tempMovie.rating
//        movie.rlsdate = tempMovie.rlsDate
//        movie.url = tempMovie.name
//        println(movie.url)
        
    }
    
    //
    
    
    func coreDataAdd(score: NSNumber){
        let entityDescription = NSEntityDescription.entityForName("Movie", inManagedObjectContext: managedObjectContext!)
        if let moc = self.managedObjectContext{
            Movie.createMoviesManagedObjectContext(moc, name: tempMovie.name, url: tempMovie.url, rlsDate: tempMovie.rlsDate, score: tempMovie.score, summary: tempMovie.summary, rating: tempMovie.rating, cast: tempMovie.cast, genre: tempMovie.genre, avgUserScore: tempMovie.avgUserScore, runtime: tempMovie.runtime, personalScore: self.movieScore, director: self.movieDetail["director"] as! String,thumbnail: self.movieDetail["thumbnail"] as! String)
            var error: NSError?
            managedObjectContext?.save(&error)
            
            if let err = error{
                println(err.localizedFailureReason)
            }else{
                println("success")
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(tempMovie.avgUserScore)
        api.delegate = self
        api.searchMetacritic(tempMovie.name, typeTerm: "movieDetail")
        trailerAPI.delegate = self
        trailerAPI.searchTrailerApi(tempMovie.name)
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