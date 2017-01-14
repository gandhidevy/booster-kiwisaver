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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuNavigation:UISideMenuNavigationController = (storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController)!
        //Define Menu
        SideMenuManager.menuLeftNavigationController = menuNavigation
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                //set menu controller delegate
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {

        let qViewController:UIViewController
            
        if indexPath.section == 0 {
            qViewController = UIStoryboard(name: "InvestorTypes", bundle: nil).instantiateInitialViewController()!
        }else {
            qViewController = UIStoryboard(name: "Questionnaire", bundle: nil).instantiateInitialViewController()!
        }
        
        addChildViewController(qViewController)
        view.addSubview(qViewController.view)
        
        qViewController.view.frame = view.bounds
        qViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        qViewController.didMove(toParentViewController: self)
        
        qViewController.view.alpha = 0
        qViewController.view.layoutIfNeeded()
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
