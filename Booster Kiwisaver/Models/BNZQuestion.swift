//
//  BNZQuestion.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import Foundation

class BNZQuestion {
    let text:String
    var possibleAnsers = [BNZAnswer]()
    
    var selectedAnswerIndex:Int?
    
    init(text:String) {
        self.text = text
    }
    
}
