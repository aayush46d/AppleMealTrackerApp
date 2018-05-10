//
//  Meal.swift
//  FoodTracker
//
//  Created by Developer on 5/10/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class Meal{
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initializer
    init?(name: String, photo: UIImage?, rating: Int) {
        
        guard !name.isEmpty
        else {
            return nil
        }
        
        guard (rating >= 0) && (rating <=  5)
        else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    
    }
}
