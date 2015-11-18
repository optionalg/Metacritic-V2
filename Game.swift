//
//  Game.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 18/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation
import CoreData

class Game: Media {

    @NSManaged var developer: String
    @NSManaged var platform: String
    @NSManaged var publisher: String
    @NSManaged var rating: String

}
