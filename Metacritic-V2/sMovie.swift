//
//  sMovie.swift
//  Metacritic-V2
//
//  Created by Ajay Raj on 14/11/2015.
//  Copyright (c) 2015 Ajay Raj. All rights reserved.
//

import Foundation

struct sMovie{
    var name : String
    var url : String
    var rlsDate : String
    var score : String
    var summary : String
    var rating : String
    var cast : String
    var genre : String
    var avgUserScore : String
    var runtime : String = ""

    init (){
        self.name = ""
        self.url = ""
        self.rlsDate = ""
        self.score = ""
        self.summary = ""
        self.rating = ""
        self.cast = ""
        self.genre = ""
        self.avgUserScore = ""
        self.runtime = ""
    }
    init(name : String, url:String, rlsDate : String, score: String, summary:String,rating:String, cast:String, genre: String, avgUserScore: String, runtime: String){
        self.name = name
        self.url = url
        self.rlsDate = rlsDate
        self.score = score
        self.summary = summary
        self.rating = rating
        self.cast = cast
        self.genre = genre
        self.avgUserScore = avgUserScore
        self.runtime = runtime
    }
}