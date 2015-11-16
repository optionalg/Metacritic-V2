//
//  userReviews.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 14/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation

struct userReviews{
    var name : String
    var score : String
    var date : String
    var review : String
    
    init(name: String, score: String, date : String, review: String){
        self.name = name
        self.score = score
        self.date  = date
        self.review = review
    }
}