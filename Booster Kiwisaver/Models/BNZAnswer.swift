//
//  Answers.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import Foundation

class BNZAnswer: NSObject {
    
    var text:String = ""
    var score:Int = 0
    
    //Indicator to show that user must end their survey now
    var forceFinishSurvey:Bool = false
    var forceInvestorType:InvestorType?
    
    var nextQuestionIndex:Int = -1
    
    init(text:String, score:Int, nextQuestionIndex:Int) {
        self.text = text
        self.score = score
        self.nextQuestionIndex = nextQuestionIndex
    }
    
    init(text:String, score:Int, forceFinishSurvey:Bool, forceInvestorType:InvestorType) {
        self.text = text
        self.score = score
        self.forceFinishSurvey = forceFinishSurvey
        self.forceInvestorType = forceInvestorType
    }
}
