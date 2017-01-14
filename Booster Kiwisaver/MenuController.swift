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
    
    let menuSectionTitles = ["Investor Type", "Questionaire"]
    
    let menuItems = [
        ["Defensive", "Conservative", "Balanced", "Balanced Growth", "Growth", "Aggressive Growth"],
        ["Submit",]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
}
