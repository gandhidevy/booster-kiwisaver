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
    var finalScore:Int!
    var investorType:InvestorType!
    
    override func viewDidLoad() {
        
        scoreLabel.text = "\(finalScore!)"
        
        let smallHeader = [NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 18)]
        let largeHeader = [NSForegroundColorAttributeName : UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 26)]
        
        let attrString:NSMutableAttributedString = NSMutableAttributedString(string: "You are a", attributes: smallHeader)
        attrString.append(NSAttributedString(string: "\n\(investorType.name)\n", attributes: largeHeader))
        attrString.append(NSAttributedString(string: "investor", attributes: smallHeader))
        
        investorTypeLabel.attributedText = attrString
    }
    
}
