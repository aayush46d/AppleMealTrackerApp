//
//  RatingController.swift
//  FoodTracker
//
//  Created by Developer on 5/9/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

@IBDesignable class RatingController: UIStackView {
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount = 5{
        didSet {
            setupButtons()
        }
    }
    
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    
    // MARK: Initializer Section
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button)
            else {
            fatalError("No such button :\(button) in : \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        
        
        if selectedRating == rating {
            rating = 0
        }
        else{
//            for (id, butt) in ratingButtons.enumerated(){
//                butt.isHighlighted = id < selectedRating
//            }
            rating = selectedRating
        }
        
//        print("Button pressed 👍")
    }
    
    // MARK: Private Methods
    private func setupButtons() {
        
        for buton in ratingButtons{
            removeArrangedSubview(buton)
            buton.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith:self.traitCollection)
        
        for index in 0..<starCount {
            
            let button = UIButton()
//            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
            button.setImage(emptyStar, for: UIControlState.normal)
            button.setImage(filledStar, for: UIControlState.selected)
            button.setImage(highlightedStar, for: UIControlState.highlighted)
            
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //Add contraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // accessibility label
            button.accessibilityLabel = "Set \(index+1) star rating."
            
            //Setup button action
            button.addTarget(self, action: #selector(RatingController.ratingButtonTapped(button:)), for: UIControlEvents.touchUpInside)
            
            // add button to stack
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            let hintString: String?
            if rating == index+1 {
                hintString = "tap to reset"
            } else{
                hintString = nil
            }
            let valueString : String
            switch(rating){
            case 0:
                valueString = "No rating given"
            case 1:
                valueString = "1 star rating provided"
            default:
                valueString = "\(rating) rating star set"
            }
            // Assign hints
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            button.isSelected = index < rating
        }
    }
    
}
