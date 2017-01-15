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
    
    init(text:String, score:Int) {
        self.text = text
        self.score = score
    }
    
}
