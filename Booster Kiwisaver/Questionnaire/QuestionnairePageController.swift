//
//  QuestionnaireController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 14/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class QuestionnairePageController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var currentPageIndex:Int = 0

    var pageViewController: UIPageViewController!
    var questions:[BNZQuestion]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        questions = buildQuestions()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        let content = viewcontrollerAt(index: 0)
        
        pageViewController.setViewControllers([content!], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChildViewController(pageViewController)
        containerView.addSubview(pageViewController.view)
        
        pageViewController?.view.frame = containerView.bounds
        pageViewController?.view.layoutIfNeeded()
        
        pageViewController.didMove(toParentViewController: self)
        
        configureNextButton()
        
        nextButton.clipsToBounds = true
        nextButton.layer.borderColor = UIColor.verySoftGreen().cgColor
        nextButton.layer.borderWidth = 2
        nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    /**
        Get viewcontroller at index
     */
    func viewcontrollerAt(index:Int) -> UIViewController? {
        
        if index < 0 || index > questions.count {
            return nil
        }
        
        if index == questions.count {
            //We have reached the end of the questionaire, save result and present the user final score
            
            let finalScore:Int = sumFinalScore()
            
            let investorType:InvestorType = InvestorType.getInvestorTypeBaseOn(score: finalScore)!
            
            return loadResultViewController(finalScore: finalScore, investorType: investorType)
        }
        
        
        let vc:QuestionnaireContentController = storyboard?.instantiateViewController(withIdentifier: "QuestionnaireContentController") as! QuestionnaireContentController
        vc.pageIndex = index
        vc.pageViewController = self
        let question = questions[index]
        
        vc.question = question
        return vc

    }
    
    func loadResultViewController(finalScore:Int, investorType:InvestorType) -> UIViewController? {
        
        let vc:QuestionnaireResultController = storyboard?.instantiateViewController(withIdentifier: "QuestionnaireResultController") as! QuestionnaireResultController
        vc.finalScore = finalScore
        vc.investorType = investorType
        
        //Save final score
        let defaults = UserDefaults.standard
        defaults.set(finalScore, forKey: "QuestionaireFinalScore")
        defaults.set(investorType.name, forKey: "QuestionaireFinalInvestorType")
        defaults.synchronize()
        
        return vc

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
    func sumFinalScore() -> Int {
        var finalScore:Int = 0
        
        for q in questions {
            if q.selectedAnswerIndex > -1 {
                let answer:BNZAnswer = q.possibleAnsers[q.selectedAnswerIndex] as BNZAnswer
                finalScore+=answer.score
            }
        }
        
        return finalScore
    }
    
    /*
        Action for when Next button is selected in the pager
     */
    @IBAction func actionNextPage(_ sender: Any) {
        
        if currentPageIndex == questions.count {
            //display new screen
            
            let defaults = UserDefaults.standard
            let score:Int = defaults.integer(forKey: "QuestionaireFinalScore")
            let investorType =  InvestorType.getInvestorTypeBasedOn(string:defaults.string(forKey: "QuestionaireFinalInvestorType")!)
            
            if score > 0 {
                let mainController = parent as! MainController
                mainController.showInvestor(type: investorType!)
            }
            
            return
        }
        
        //Just do a check to see if the user has to jump to end of survey
        let question = questions[currentPageIndex]
        let answer = question.possibleAnsers[question.selectedAnswerIndex]
        if answer.forceFinishSurvey {
            if let controller = loadResultViewController(finalScore: sumFinalScore(), investorType: answer.forceInvestorType!) {
                pageViewController.setViewControllers([controller], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
                configureNextButton()
                currentPageIndex = questions.count
                nextButton.setTitle("Show", for: UIControlState.normal)
                return;
            }
        }
        
        currentPageIndex = answer.nextQuestionIndex
        
        if let content = viewcontrollerAt(index:currentPageIndex) {
            pageViewController.setViewControllers([content], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            configureNextButton()
        }
        
        if currentPageIndex == questions.count {
            nextButton.setTitle("Show", for: UIControlState.normal)
        }
    }
    
    /**
        Call to validate if next button should be enabled. It is only enabled when the question in current page is selected, and when the questionaire is complete
     */
    func configureNextButton() {

        if currentPageIndex >= questions.count {
            nextButton.isEnabled = true
        }else{
            let question = questions[currentPageIndex]
            nextButton.isEnabled = question.selectedAnswerIndex > -1
        }
    }
    
    //Build the data models
    private func buildQuestions()->[BNZQuestion] {
        
        var nextQuestionIndex:Int = 1

        //Question 1
        let q1:BNZQuestion = BNZQuestion(text: "When do you plan to make a significant lump sum withdrawal from your portfolio, for example, for the purchase of a first home or for retirement needs? (From age 65 at the earliest)")
        q1.possibleAnsers = [
            
            BNZAnswer(text: "Within 2 years", score: 1, forceFinishSurvey: true, forceInvestorType: InvestorType.Defensive()),
            BNZAnswer(text: "In 2 to 5 years", score: 3, forceFinishSurvey: true, forceInvestorType: InvestorType.Conservative()),
            BNZAnswer(text: "In 6 to 10 years", score: 5, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "In 11 to 20 years", score: 7, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "More than 20 years", score: 10, nextQuestionIndex: nextQuestionIndex),
        ]
        
        nextQuestionIndex+=1
        
        //Question 2
        let q2:BNZQuestion = BNZQuestion(text: "Which of the following questions best describes your thoughts about risks and returns?")
        
        q2.possibleAnsers = [
            BNZAnswer(text: "I want to minimise my risk and am therefore willing to accept low returns", score: 1, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I am willing to take a moderate amount of risk to generate low to medium returns", score: 3, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I am willing to take a reasonable amount of risk to provide a more medium return", score: 5, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "In order to receive higher returns, I am willing to take a relatively high amount of risk", score: 7, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I want to maximise my returns and am willing to accept a high level of risk ", score: 10, nextQuestionIndex: nextQuestionIndex),
        ]
        
        nextQuestionIndex+=1

        //Question 3
        let q3:BNZQuestion = BNZQuestion(text: "Protecting my investment portfolio from a fall in value at any time is more important to me than achieving high returns?")
        
        q3.possibleAnsers = [
            BNZAnswer(text: "Strongly Agree", score: 1, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Agree", score: 3, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Neither agree or disagree", score: 5, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Disagree", score: 7, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Strongly Disagree", score: 10, nextQuestionIndex: nextQuestionIndex),
        ]
        
        nextQuestionIndex+=1

        //Question 4
        let q4:BNZQuestion = BNZQuestion(text: "Consider you have an investment balance of at least $20,000 or more. If after a short period of time (less than 1 year) your balance has dropped in value, which statement relects best how you would feel about this?")
        
        q4.possibleAnsers = [
            BNZAnswer(text: "I would be unhappy with any drop in value ", score: 1, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I would be OK with a drop in value of no more than 5%", score: 3, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I would be OK with a drop in value of no more than 10% ", score: 5, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I would be OK with a drop in value of up to 15%", score: 7, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "I would be OK with a drop in value of up to 20% ", score: 10, nextQuestionIndex: nextQuestionIndex),
        ]
        
        nextQuestionIndex+=1

        //Question 5
        let q5:BNZQuestion = BNZQuestion(text: "How often would you tend to worry about your investment returns?")
        
        q5.possibleAnsers = [
            BNZAnswer(text: "Daily", score: 1, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Monthly", score: 3, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Quarterly", score: 5, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Annually", score: 7, nextQuestionIndex: nextQuestionIndex),
            BNZAnswer(text: "Never or only occasionally over the longer term", score: 10, nextQuestionIndex: nextQuestionIndex),
        ]
    
        return [q1,q2,q3,q4,q5]
        
    }
    
    
}
