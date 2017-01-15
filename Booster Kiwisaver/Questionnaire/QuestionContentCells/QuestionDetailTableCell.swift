//
//  QuestionDetailTableCell.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class QuestionDetailTableCell: BaseQuestionCell {
    
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var questionDetailLabel: UILabel!
    
    
    override func awakeFromNib() {
        selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    override func populateCell(object: Any?) {
        let question:BNZQuestion = object as! BNZQuestion
        
        questionDetailLabel.text = question.text
    }
    
}
