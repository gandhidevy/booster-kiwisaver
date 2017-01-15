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
    
    let allPieChartColors = [UIColor.moderateBlue(), UIColor.lessModerateBlue(), UIColor.verySoftBlue(), UIColor.verySoftGreen(), UIColor.veryVerySoftGreen(), UIColor.lightGrayishGreen()]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.noDataText = "You need to provide data for the chart."
        
        investorTypeTitleLabel.text = investorType.name
        
        let fund:SectorFund = investorType.fundType
        setFormattedDetails(string: fund.fundDescription)
        
        setChart(fund: fund)
    }
    
    func setChart(fund:SectorFund) {
        let assets = ["Cash and cash equivalents", "New Zealand fixed interest", "International fixed interest", "Australasian equities", "International equities", "Listed property"]
        let dataValues = [fund.cashAndCashEquivalents, fund.nzFixedInterest, fund.internationalFixedInterest, fund.australassianEquities, fund.internationalEquities, fund.listedProperty]
        
        var colors:[UIColor] = []
        
        var dataEntries: [ChartDataEntry] = []

        var index = 0
        for i in 0..<assets.count {
            let value = dataValues[i]
            if value > 0 {
                let dataEntry = PieChartDataEntry(value: Double(value), label: assets[i])//ChartDataEntry(x: Double(value), y: Double(value))
                dataEntries.append(dataEntry)
                colors.append(allPieChartColors[i])
                //increment index
                index += 1
            }else{

            }
        }
        
        //Set pie chart dataset and colors
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Test")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.colors = colors
        pieChartDataSet.valueTextColor = UIColor.black
        pieChartDataSet.valueLinePart1Length
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
