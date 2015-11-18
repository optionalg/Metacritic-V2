//
//  Media.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 18/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation
import CoreData

class Media: NSManagedObject {

    @NSManaged var genre: String
    @NSManaged var name: String
    @NSManaged var rlsdate: String
    @NSManaged var score: String
    @NSManaged var summary: String
    @NSManaged var thumbnail: String
    @NSManaged var url: String
    @NSManaged var userScore: String
    @NSManaged var personalScore : NSNumber

}
