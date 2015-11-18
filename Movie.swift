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

}
