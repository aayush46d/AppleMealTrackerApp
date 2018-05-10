//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: Meal class test
    
    // Confirm meal objects when proper values are added
    func testMealInitializationSucceeds() {
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let nonZeroRatingMeal = Meal.init(name: "Five", photo: nil, rating: 5)
        XCTAssertNotNil(nonZeroRatingMeal)
    }
    
    //Confirm nil object is returned by meal for invalid arguments
    func testFailableInitializer(){
        
        let negativeRatingMeal = Meal.init(name: "neg", photo: nil, rating: -2)
        XCTAssertNil(negativeRatingMeal)
        
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 24)
        XCTAssertNil(emptyStringMeal)
        
        
    }
    
}
