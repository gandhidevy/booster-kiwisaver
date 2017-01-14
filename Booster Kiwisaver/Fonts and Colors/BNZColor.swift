//
//  File.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 14/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex:Int) {
//        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue: hex & 0xff);
        self.init(
            red:CGFloat((hex >> 16) & 0xff),
            green:CGFloat((hex >> 8) & 0xff),
            blue:CGFloat(hex & 0xff),
            alpha:1.0
        )

    }
    
    class func boosterBlue() -> UIColor {
        return UIColor.init(hex:0x007fc4);
    }
}
