//
//  QuestionnaireResultController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class QuestionnaireResultController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var investorTypeLabel: UILabel!
    
    var questionsResults:[BNZQuestion]?
    
    override func viewDidLoad() {
    
        var finalScore:Int = 0
        
        for q in questionsResults! {
            let answer:BNZAnswer = q.possibleAnsers[q.selectedAnswerIndex] as BNZAnswer
            finalScore+=answer.score
        }
        
        scoreLabel.text = "\(finalScore)"
        
        let investorType:InvestorType = InvestorType.getInvestorTypeBaseOn(score: finalScore)!
        
        let smallHeader = [NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 18)]
        let largeHeader = [NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 26)]
        
        let attrString:NSMutableAttributedString = NSMutableAttributedString(string: "You are a", attributes: smallHeader)
        attrString.append(NSAttributedString(string: "\n\(investorType.name)\n", attributes: largeHeader))
        attrString.append(NSAttributedString(string: "investor", attributes: smallHeader))
        
        investorTypeLabel.attributedText = attrString
    
        let defaults = UserDefaults.standard
        defaults.set(finalScore, forKey: "QuestionaireFinalScore")
        defaults.synchronize()
    }
    
}
