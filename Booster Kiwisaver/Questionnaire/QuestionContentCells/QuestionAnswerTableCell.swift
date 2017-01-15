//
//  QuestionAnswerTableCell.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class QuestionAnswerTableCell: BaseQuestionCell {
    
    @IBOutlet weak var answerButton: UIButton!
    
    override func awakeFromNib() {
        answerButton.backgroundColor = UIColor.white
        answerButton.clipsToBounds = true
        answerButton.layer.cornerRadius = 5
        answerButton.layer.borderWidth = 2
        answerButton.layer.borderColor = UIColor.boosterBlue().cgColor
        
    }
    
    override func populateCell(object: Any?) {
        let answer:BNZAnswer = object as! BNZAnswer
        answerButton.setTitle(answer.text, for: UIControlState.normal)
        
        answerButton.sizeToFit()
    }
    
    func setButtonSelected(selected:Bool) {
        answerButton.isSelected = selected
        
        answerButton.backgroundColor = selected ? UIColor.boosterBlue() : UIColor.white
    }
}
