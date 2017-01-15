//
//  MainControler.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 14/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit
import SideMenu

class MainController : UIViewController, UIMenuDelegate  {
    
    @IBOutlet weak var containerView: UIView!
    
    var currentView:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuNavigation:UISideMenuNavigationController = (storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController)!
        //Define Menu
        SideMenuManager.menuLeftNavigationController = menuNavigation
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        SideMenuManager.menuFadeStatusBar = false
                
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        //show initial screen
        currentView = storyboard?.instantiateViewController(withIdentifier: "MainWelcomeScreen")
        
        self.addChildViewController(currentView!)
        containerView.addSubview(currentView!.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                //set menu controller delegate
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {

        let qViewController:UIViewController
            
        if indexPath.section == 0 {
            let fundController:InvestorFundController = UIStoryboard(name: "InvestorFund", bundle: nil).instantiateInitialViewController()! as! InvestorFundController
            
            fundController.investorType = InvestorType.getAllInvestorTypes()[indexPath.row]
            
            qViewController = fundController
        }else {
            
            if !MenuController.isReadyToSubmit() {
                qViewController = UIStoryboard(name: "Submit", bundle: nil).instantiateInitialViewController()!
                
            }else {
                let questionairePageControl:QuestionnairePageController = UIStoryboard(name: "Questionnaire", bundle: nil).instantiateInitialViewController()! as! QuestionnairePageController

                qViewController = questionairePageControl
            }
        }
        
        cycleFromViewController(toViewController: qViewController)
    }
    
    func cycleFromViewController(toViewController newViewController: UIViewController) {
        
        currentView!.willMove(toParentViewController: nil)
        addChildViewController(newViewController)
        containerView.addSubview(newViewController.view)
        newViewController.view.frame = view.bounds
        
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            newViewController.view.alpha = 1
            self.currentView!.view.alpha = 0
        }, completion:{ (Bool) in
            self.currentView!.view.removeFromSuperview()
            self.currentView!.removeFromParentViewController()
            newViewController.didMove(toParentViewController: self)
        })
    }
    
    func showInvestor(type:InvestorType) {
        let fundController:InvestorFundController = UIStoryboard(name: "InvestorFund", bundle: nil).instantiateInitialViewController()! as! InvestorFundController
        
        fundController.investorType = type
        
        cycleFromViewController(toViewController: fundController)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Just making sure we have the correct segue for the menu controller
        if segue.destination is UISideMenuNavigationController {
            let menuNavigation:UISideMenuNavigationController = segue.destination as! UISideMenuNavigationController
            let menuController = (menuNavigation.topViewController as! MenuController)
            menuController.menuDelegate = self
        }
    }
}
