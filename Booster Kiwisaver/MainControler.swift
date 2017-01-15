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
        
        //Define Menu
        let menuNavigation:UISideMenuNavigationController = (storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController)!
        SideMenuManager.menuLeftNavigationController = menuNavigation
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        SideMenuManager.menuFadeStatusBar = false
        
        //Add central Title view logo
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        //show initial screen
        currentView = storyboard?.instantiateViewController(withIdentifier: "MainWelcomeScreen")
        self.addChildViewController(currentView!)
        containerView.addSubview(currentView!.view)
    }
    
    /**
     * Delect method called when a menu item has been selected
     */
    func didSelectMenuItem(indexPath: IndexPath) {
        
        switch indexPath.section {
            //Load Welcome controler
            case 0:
                return showWelcome()
            //Load Investor Fund type screens
            case 1:
                return showInvestor(type: InvestorType.getAllInvestorTypes()[indexPath.row])
            //Load questionaire or submit screen
            case 2:
                return showQuestionaire(orSubmit: !MenuController.isReadyToSubmit())
            default:
                break
        }
        
    }
    
    func cycleFromViewController(toViewController newViewController: UIViewController) {
        
        currentView!.willMove(toParentViewController: nil)
        addChildViewController(newViewController)
        containerView.addSubview(newViewController.view)
        newViewController.view.frame = view.bounds
        
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2, animations: {
            newViewController.view.alpha = 1
            self.currentView!.view.alpha = 0
        }, completion:{ (Bool) in
            self.currentView!.view.removeFromSuperview()
            self.currentView!.removeFromParentViewController()
            newViewController.didMove(toParentViewController: self)
        })
    }
    
    func showQuestionaire(orSubmit submit:Bool) {
        
        var qViewController:UIViewController!

        if submit {
            qViewController = UIStoryboard(name: "Submit", bundle: nil).instantiateInitialViewController()!
        }else {
            qViewController = UIStoryboard(name: "Questionnaire", bundle: nil).instantiateInitialViewController()! as! QuestionnairePageController
        }
        
        cycleFromViewController(toViewController: qViewController)
    }
    
    func showWelcome() {
        let controller = (storyboard?.instantiateViewController(withIdentifier: "MainWelcomeScreen"))!
        cycleFromViewController(toViewController: controller)
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
