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
        self.init(
            red:CGFloat(0xff & hex >> 16) / 255.0,
            green:CGFloat((0xff & hex >> 8) ) / 255.0,
            blue:CGFloat(0xff & hex) / 255.0,
            alpha:1.0
        )
    }
    
    class func boosterBlue() -> UIColor {
        return UIColor.init(hex:0x007fc4);
    }
    
    //Pie Chart Colors
    class func moderateBlue() -> UIColor {
        return UIColor.init(hex: 0x388ecd)
    }
    
    class func lessModerateBlue() -> UIColor {
        return UIColor.init(hex: 0x669fd5)
    }
    
    class func verySoftBlue() -> UIColor {
        return UIColor.init(hex: 0x9dbde3)
    }
    
    class func verySoftGreen() -> UIColor {
        return UIColor.init(hex: 0xbadb92)
    }
    
    class func veryVerySoftGreen() -> UIColor {
        return UIColor.init(hex: 0xd2e7b8)
    }
    
    class func lightGrayishGreen() -> UIColor {
        return UIColor.init(hex: 0xe3f0d3)
    }
}
