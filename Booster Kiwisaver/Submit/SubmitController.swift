//
//  SubmitController.swift
//  Booster Kiwisaver
//
//  Created by Devyish Gandhi on 15/01/17.
//  Copyright © 2017 Davanti Consulting. All rights reserved.
//

import UIKit
import MessageUI

class SubmitController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.clipsToBounds = true
        self.submitButton.layer.cornerRadius = 5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField {
            phoneTextField.becomeFirstResponder()
        } else {
            actionSubmit(submitButton)
        }
        
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func actionTapView(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    func dismissKeyboard(){
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        //Send out email
        dismissKeyboard()
        
        let name:String = (nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let email:String = (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let phone:String = (phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        if name.characters.count == 0 || phone.characters.count == 0 || !isValidEmail(testStr: email){
            //NOT all fields have been filled in yet.
            showAlert(title: "Invalid Submission", msg: "One or more fields is either empty or not valid. Please check again before submitting.", cancelText: "Understood")
            return
        }
        
        //Open email
        if !MFMailComposeViewController.canSendMail() {
            print("Mail service unavailable")
            
            showAlert(title: "Mail Service Unavailable", msg: "Please run on a physical device or setup a mail account.", cancelText: "Understood")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["me@example.com"])
        composeVC.setSubject("Completed questionaire submission")
        
        let defaults = UserDefaults.standard
        
        let msg:String = "Hello, \n\nThese are my details and score: \nName: \(name) \nEmail: \(email) \nPhone: \(phone) \n\nMy score for the questionaire was: \(defaults.integer(forKey: "QuestionaireFinalScore"))"
        
        composeVC.setMessageBody(msg, isHTML: false)
        
        // Present the view controller modally.
        present(composeVC, animated: true, completion: nil)
    }
    
    func showAlert(title:String, msg:String, cancelText:String) {
        
        let alert:UIAlertController = UIAlertController(title:title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: cancelText, style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Mail Methods
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .sent:
            //Only handling scenario for a successfully sent email, as the requirementts for other cases ie. saved has not been defined
            let defaults = UserDefaults.standard
            defaults.set(0, forKey: "QuestionaireFinalScore")
            defaults.set("", forKey: "QuestionaireFinalInvestorType")
            defaults.synchronize()
            
            
            //Present success message to user
            let alert:UIAlertController = UIAlertController(title:"Yay", message: "Your score has been submitted! We will be in contact shortly.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                let main:MainController = self.parent as! MainController
                main.showWelcome()
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
}
