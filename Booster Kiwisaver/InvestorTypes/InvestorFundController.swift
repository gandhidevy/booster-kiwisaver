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
    
    @IBOutlet weak var growthAssetsLabel: UILabel!
    @IBOutlet weak var incomeAssetsLabel: UILabel!
    
    let allPieChartColors = [UIColor.moderateBlue(), UIColor.lessModerateBlue(), UIColor.verySoftBlue(), UIColor.verySoftGreen(), UIColor.veryVerySoftGreen(), UIColor.lightGrayishGreen()]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.noDataText = "You need to provide data for the chart."
        
        investorTypeTitleLabel.text = investorType.name
        
        let fund:SectorFund = investorType.fundType
        setFormattedDetails(string: fund.fundDescription)
        
        growthAssetsLabel.text = "Growth Assets: \(Int(fund.growthAssetsPercent()))%"
        incomeAssetsLabel.text = "Income Assets: \(Int(fund.incomeAssetsPercent()))%"
        
        setChart(fund: fund)
    }
    
    /**
     Setup pie chart with data and styling pie chart
     */
    func setChart(fund:SectorFund) {
        let assets = ["Cash and cash equivalents", "New Zealand fixed interest", "International fixed interest", "Australasian equities", "International equities", "Listed property"]
        let dataValues = [fund.cashAndCashEquivalents, fund.nzFixedInterest, fund.internationalFixedInterest, fund.australassianEquities, fund.internationalEquities, fund.listedProperty]
        
        var colors:[UIColor] = []
        
        var dataEntries: [ChartDataEntry] = []

        var index = 0
        for i in 0..<assets.count {
            let value = dataValues[i]
            if value > 0 {
                let dataEntry = PieChartDataEntry(value: Double(value), label: "\(assets[i]) - \(value)%")
                dataEntries.append(dataEntry)
                colors.append(allPieChartColors[i])
                //increment index
                index += 1
            }else{

            }
        }
        
        //Set pie chart dataset and colors
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartDataSet.colors = colors
        pieChartDataSet.valueTextColor = UIColor.black
        pieChartView.drawEntryLabelsEnabled = false
        pieChartDataSet.yValuePosition = .outsideSlice

        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .percent
        numFormatter.maximumFractionDigits = 1
        numFormatter.multiplier = 1.0
        numFormatter.percentSymbol = " %"
        
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: numFormatter))
        pieChartView.data = pieChartData
        
        //Remove 'Description Label' text
        let descript:Description = Description()
        descript.text = ""
        
        //Pie chart offest value
        let offset:CGFloat = 10.0
        pieChartView.chartDescription = descript
        pieChartView.setExtraOffsets(left: offset, top: 0, right: offset, bottom: 0)
    }
    
    /**
     Format UILabel for bullet point styling.
    */
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
