//
//  Movie.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 18/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation
import CoreData

class Movie: Media {

    @NSManaged var cast: String
    @NSManaged var director: String
    @NSManaged var rating: String
    @NSManaged var runtime: String

    
    class func createMoviesManagedObjectContext(moc:NSManagedObjectContext, name: String, url: String, rlsDate: String, score: String, summary: String, rating: String, cast: String, genre: String, avgUserScore: String, runtime: String, personalScore: NSNumber, director: String,thumbnail: String) -> Movie{
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Movie", inManagedObjectContext: moc) as! Movie
        newItem.name = name
        newItem.url  = url
        newItem.rlsdate = rlsDate
        newItem.score = score
        newItem.summary = summary
        newItem.rating = rating
        newItem.cast = cast
        newItem.genre = genre
        newItem.userScore = avgUserScore
        newItem.runtime = runtime
        newItem.personalScore = personalScore
        newItem.director = director
        newItem.thumbnail = thumbnail
        
        return newItem
        
    }
    
}
