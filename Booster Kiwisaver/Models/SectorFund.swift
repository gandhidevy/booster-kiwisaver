//
//  SectorFund.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class SectorFund {
    var name = ""
    var fundDescription = ""
    
    var cashAndCashEquivalents:Float = 0.0
    var nzFixedInterest:Float = 0.0
    var internationalFixedInterest:Float = 0.0
    var australassianEquities:Float = 0.0
    var internationalEquities:Float = 0.0
    var listedProperty:Float = 0.0
    
    required init(name:String, fundDescription:String, cashAndCashEquivalents:Float, nzFixedInterest:Float, internationalFixedInterest:Float, australassianEquities:Float, internationalEquities:Float, listedProperty:Float) {
        
        self.name = name
        self.fundDescription = fundDescription
        self.cashAndCashEquivalents = cashAndCashEquivalents
        self.nzFixedInterest = nzFixedInterest
        self.internationalFixedInterest = internationalFixedInterest
        self.internationalEquities = internationalEquities
        self.listedProperty = listedProperty
    }
    
    func growthAssetsPercent() -> Float {
        return australassianEquities + internationalEquities + listedProperty
    }
    
    func incomeAssetsPercent() -> Float {
        return cashAndCashEquivalents + nzFixedInterest + internationalFixedInterest
    }
    
    class func CapitalGuaranteed() -> SectorFund {

        return self.init(name: "Capital Guaranteed Fund",
                         fundDescription:"•  The fund aims to provide relatively consistent returns, subject to a capital guarantee.\n•  It aims to achieve returns – after fees but before tax – of at least 1.5% per year above inflation over any 2-year period.\n•  Generally, there may be small movements up and down in the value of the fund.\n•  The fund invests mainly in income assets, and includes only a small amount of growth assets.",
                         cashAndCashEquivalents: 60.0,
                         nzFixedInterest: 15.0,
                         internationalFixedInterest: 10.0,
                         australassianEquities:5.0,
                         internationalEquities: 5.0,
                         listedProperty: 0.0)
    }
    
    class func DefaultSaverFund() -> SectorFund {
        
        return self.init(name: "Default Saver Fund",
                         fundDescription:"•  The fund aims to provide relatively consistent but modest returns, with some capital gains over the long term.\n•  It aims to achieve achieve returns – after fees but before tax – of at least 2.0% per year above inflation over any 3-year period.\n•  Generally, there will be small movements up and down in the value of the fund, reflecting its temporary holding nature.\n•  The fund invests mainly in income assets, but includes some growth assets.",
                         cashAndCashEquivalents: 20,
                         nzFixedInterest: 35,
                         internationalFixedInterest: 25,
                         australassianEquities:7,
                         internationalEquities: 11,
                         listedProperty: 2)
    }
    
    class func ModerateFund() -> SectorFund {
        
        return self.init(name: "Moderate Fund",
                         fundDescription:"•  The fund aims to provide relatively consistent returns, with some capital gains over the long-term.\n•  It aims to achieve returns – after fees but before tax – of at least 2.5% per year above inflation over any four year period.\n•  Generally, there will be some movements up and down in the value of the fund.\n•  The fund invests mainly in income assets, but includes some growth assets.",
                         cashAndCashEquivalents: 30,
                         nzFixedInterest: 20,
                         internationalFixedInterest: 12,
                         australassianEquities:19,
                         internationalEquities: 4,
                         listedProperty: 15)
    }
    
    class func BalanceFund() -> SectorFund {
        
        return self.init(name: "Balance Fund",
                         fundDescription:"•  The fund aims to provide an enhanced return over the long term through capital gains.\n•  It aims to achieve returns – after fees but before tax – of at least 3% per year above inflation over any 5-year period.\n•  There will be some movements up and down in the value of the fund.\n•  The fund invests in a more balanced mix of income assets and growth assets.",
                         cashAndCashEquivalents: 2,
                         nzFixedInterest: 17,
                         internationalFixedInterest: 26,
                         australassianEquities:18,
                         internationalEquities: 30,
                         listedProperty: 7)
    }
    
    class func BalanceGrowthFund() -> SectorFund {
        
        return self.init(name: "Balance Growth Fund",
                         fundDescription:"•  The fund aims to provide long-term capital gains but to partially offset short-term movements up and down with some income assets.\n•  It aims to achieve returns – after fees but before tax –  of at least 4% per year above inflation over any 7-year period.\n•  There will be larger movements up and down in the value of the fund compared to the Balanced Fund.\n•  The fund invests mainly in growth assets, but includes some income assets.",
                         cashAndCashEquivalents: 2,
                         nzFixedInterest: 9,
                         internationalFixedInterest: 14,
                         australassianEquities:25,
                         internationalEquities: 41,
                         listedProperty: 9)
    }
    
    class func HighGrowthFund() -> SectorFund {
        
        return self.init(name: "High Growth Fund",
                         fundDescription:"•  The fund aims to maximise the potential for capital gains over the long term.\n•  It aims to achieve returns – after fees but before tax – of at least 5% per year above inflation over any 10-year period.\n•  There will be significant movements up and down in the value of the fund.\n•  The fund invests predominantly in growth assets, with little or no allocation to income assets.",
                         cashAndCashEquivalents: 2,
                         nzFixedInterest: 0,
                         internationalFixedInterest: 0,
                         australassianEquities:32,
                         internationalEquities: 54,
                         listedProperty: 12)
    }
}
