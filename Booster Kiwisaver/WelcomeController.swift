//
//  ViewController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 14/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var welcomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //style welcom button
        welcomeButton.layer.cornerRadius = 5
        welcomeButton.layer.borderWidth = 1
        welcomeButton.layer.borderColor = UIColor.boosterBlue().cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

