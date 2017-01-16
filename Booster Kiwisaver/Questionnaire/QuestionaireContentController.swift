//
//  QuestionaireContentController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class QuestionnaireContentController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var pageIndex:Int!
    var pageViewController:QuestionnairePageController?
    var question:BNZQuestion?
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + (question?.possibleAnsers.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BaseQuestionCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "QuestionDetailTableCell", for: indexPath) as! BaseQuestionCell
            cell.populateCell(object:question)
            
            (cell as! QuestionDetailTableCell).questionCountLabel.text = "Question \(pageIndex + 1) of 5"
            
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "QuestionAnswerTableCell", for: indexPath) as! BaseQuestionCell
            let answerIndex:Int = indexPath.row - 1
            cell.populateCell(object: question?.possibleAnsers[answerIndex])
            (cell as! QuestionAnswerTableCell).answerButton.addTarget(self, action: #selector(actionSelectedAnswer), for: .touchUpInside)
            
            if let currentSelected = question?.selectedAnswerIndex {
                (cell as! QuestionAnswerTableCell).setButtonSelected(selected:(currentSelected == answerIndex))
            }else{
                 (cell as! QuestionAnswerTableCell).setButtonSelected(selected: false)
            }
        }
        
        return cell
    }
    
    func actionSelectedAnswer(sender:UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition);
        
        if((indexPath?.row)! > 0){
            
            
            let selectedAnswerIndex:Int = indexPath!.row - 1
            
            if (question?.selectedAnswerIndex)! > -1 {
                //unselect old answer
                (tableView.cellForRow(at: IndexPath(row: (question?.selectedAnswerIndex)! + 1, section: 0)) as! QuestionAnswerTableCell).setButtonSelected(selected: false)
            }
            
            question?.selectedAnswerIndex = selectedAnswerIndex
            //selcet new answer
            (tableView.cellForRow(at:indexPath!) as! QuestionAnswerTableCell).setButtonSelected(selected: true)
            
            if pageViewController != nil {
                pageViewController?.configureNextButton()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let answerIndex:Int = indexPath.row - 1
            let selected:Bool = question?.selectedAnswerIndex == answerIndex
            cell.setSelected(selected, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row > 0){
            
            if let currentSelected = question?.selectedAnswerIndex {
                tableView.deselectRow(at: IndexPath(row: currentSelected, section: 0), animated: false)
            }
            
            let selectedAnswerIndex:Int = indexPath.row - 1
            question?.selectedAnswerIndex = selectedAnswerIndex
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        }
    }
    
}
