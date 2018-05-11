//
//  Meal.swift
//  FoodTracker
//
//  Created by Developer on 5/10/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archive paths
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchieveURL = DocumentDirectory.appendingPathComponent("Meal")
    
    struct  propertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: propertyKey.name)
        aCoder.encode(photo,forKey: propertyKey.photo)
        aCoder.encode(rating,forKey: propertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: propertyKey.name) as? String
            else{
                os_log("Name can not be decoded", log: OSLog.default, type: .debug)
                return nil
        }
        
        let photo = aDecoder.decodeObject(forKey: propertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: propertyKey.rating)
        
        self.init(name: name, photo: photo, rating: rating)
    }
}
