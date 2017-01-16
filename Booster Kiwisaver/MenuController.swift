//
//  MenuController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 14/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

protocol UIMenuDelegate:class {
    func didSelectMenuItem(indexPath : IndexPath)
}

class MenuController: UITableViewController {
    
    var menuDelegate:UIMenuDelegate?
    
    let menuSectionTitles = ["", "Investor Type", "Questionaire"]
    
    var menuItems = [Array<String>]()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add central Title view logo
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        menuItems = [
            ["Welcome!"],
            InvestorType.getAllInvestorTypesStringValues(),
            ["Begin",]
        ]
    
        if MenuController.isReadyToSubmit() {
            menuItems[2][0] = "Submit"
        }
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - UITableView Datasource & Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuSectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MenuTableCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableCell", for: indexPath) as! MenuTableCell
        
        cell.populateCell(title: menuItems[indexPath.section][indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuDelegate?.didSelectMenuItem(indexPath: indexPath)
        //deselct the row
        tableView.deselectRow(at: indexPath, animated: true)
        //Dismiss the menu view
        self.dismiss(animated: true, completion: nil)
    }
    
    static func isReadyToSubmit() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "QuestionaireFinalScore") > 0
    }
}
