//
//  InvestorFundController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit
import Charts

class InvestorFundController: UIViewController {
    
    var investorType:InvestorType!
    
    @IBOutlet weak var investorTypeTitleLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var investmentDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.noDataText = "You need to provide data for the chart."
        
        investorTypeTitleLabel.text = investorType.name
        
        let fund:SectorFund = investorType.fundType
        setFormattedDetails(string: fund.fundDescription)
//        investmentDetails.text = fund.fundDescription
        
        setChart(fund: fund)
    }
    
    func setChart(fund:SectorFund) {
        let assets = ["Cash and cash equivalents", "New Zealand fixed interest", "International fixed interest", "Australasian equities", "International equities", "Listed property"]
        let dataValues = [fund.cashAndCashEquivalents, fund.nzFixedInterest, fund.internationalFixedInterest, fund.australassianEquities, fund.internationalEquities, fund.listedProperty]
        
        var dataEntries: [ChartDataEntry] = []
//        var colors:
        var index = 0
        for i in 0..<assets.count {
            
            if dataValues[i] > 0 {
                let dataEntry = ChartDataEntry(x: Double(dataValues[i]), y: Double(index))
                dataEntries.append(dataEntry)
                //increment index
                index += 1
            }
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Test")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.colors = [UIColor.red, UIColor.purple, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.magenta]
        pieChartView.data = pieChartData
        
    }
    
    func setFormattedDetails(string : String) {
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 4
        paragraphStyle.paragraphSpacingBefore = 10
        paragraphStyle.firstLineHeadIndent = 0.0
        paragraphStyle.headIndent = 15.0
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, string.characters.count))
        
        investmentDetails.attributedText = attributedString
    }
}
