//
//  criticReviews.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 14/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation

struct criticReviews{
    var critic : String
    var score : String
    var date : String
    var excerpt : String
    
    init(critic: String, score: String, date : String, excerpt: String){
        self.critic = critic
        self.score = score
        self.date  = date
        self.excerpt = excerpt
    }
}