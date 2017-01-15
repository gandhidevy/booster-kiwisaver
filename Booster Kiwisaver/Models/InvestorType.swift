//
//  InvestorType.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 14/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import Foundation
import UIKit

class InvestorType: NSObject {
    var name = ""
    let minScoreValue:Int
    let maxScoreValue:Int
    let fundType:SectorFund
    
    
    required init(name:String, fundType:SectorFund, minScoreValue:Int, maxScoreValue:Int) {
        
        self.name = name
        self.fundType = fundType
        self.minScoreValue = minScoreValue
        self.maxScoreValue = maxScoreValue
        
    }
    
    class func Defensive() -> InvestorType {
        return self.init(name: "Defensive", fundType: SectorFund.CapitalGuaranteed(), minScoreValue: 5, maxScoreValue: 12)
    }
    
    class func Conservative() -> InvestorType {
        return self.init(name: "Conservative", fundType: SectorFund.DefaultSaverFund(), minScoreValue: 13, maxScoreValue: 20)
    }
    
    class func Balanced() -> InvestorType {
        return self.init(name: "Balanced", fundType: SectorFund.BalanceFund(), minScoreValue: 21, maxScoreValue: 29)
    }
    
    class func BalancedGrowth() -> InvestorType {
        return self.init(name: "Balanced Growth", fundType: SectorFund.BalanceGrowthFund(), minScoreValue: 30, maxScoreValue: 37)
    }
    
    class func Growth() -> InvestorType {
        return self.init(name: "Growth", fundType: SectorFund.HighGrowthFund(), minScoreValue: 38, maxScoreValue: 44)
    }
    
    class func AggressiveGrowth() -> InvestorType {
        return self.init(name: "Aggressive Growth", fundType: SectorFund.HighGrowthFund(), minScoreValue: 45, maxScoreValue: 50)
    }
    
    static func getInvestorTypeBaseOn(score:Int) -> InvestorType? {

        
        for type in InvestorType.getAllInvestorTypes() {
            if score >= type.minScoreValue && score <= type.maxScoreValue {
                return type
            }
        }
        
        return nil
    }
    
    static func getAllInvestorTypes() -> [InvestorType]{
        return [InvestorType.Defensive(), InvestorType.Conservative(), InvestorType.Balanced(), InvestorType.BalancedGrowth(), InvestorType.Growth(), InvestorType.AggressiveGrowth()]
    }
    
    static func getAllInvestorTypesStringValues() -> [String]{
        var types = [String]()
        
        for type in InvestorType.getAllInvestorTypes() {
            types.append(type.name)
        }
        
        return types
    }
}
