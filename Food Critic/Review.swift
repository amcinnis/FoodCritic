//
//  Review.swift
//  Food Critic
//
//  Created by Austin McInnis on 3/3/17.
//  Copyright © 2017 Austin McInnis. All rights reserved.
//

import Foundation

class Review {
    var id: String?
    var name: String?
    var rating: Int?
    var summary: String?
    
    init(id: String, name: String, rating: Int, summary: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.summary = summary
    }
}
