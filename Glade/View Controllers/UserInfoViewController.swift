//
//  UserInfoViewController.swift
//  Glade
//
//  Created by Allen Gu on 1/29/21.
//

import UIKit

class UserInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: LoginSequenceButton!
    
    let years = ["Freshman", "Sophomore", "Junior", "Senior", "Alumni"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        // Prompt Label
        promptLabel.text = "Add some information about yourself:"
        promptLabel.font = Fonts.getFont(type: .bold, size: 32)
        promptLabel.numberOfLines = 0
        
        // Major Label
        majorLabel.text = "Major (e.g. CS)"
        majorLabel.font = Fonts.getFont(type: .medium, size: 18)
        majorLabel.numberOfLines = 0
        
        // Major Text Field
        majorTextField.font = Fonts.getFont(type: .regular, size: 18)
        majorTextField.delegate = self
        
        // Year Label
        yearLabel.text = "Year (e.g. Sophomore)"
        yearLabel.font = Fonts.getFont(type: .medium, size: 18)
        yearLabel.numberOfLines = 0
        
        // Year Text Field
        yearTextField.font = Fonts.getFont(type: .regular, size: 18)
        yearTextField.delegate = self
        
        // Error Message
        errorMessageLabel.text = ""
        errorMessageLabel.textColor = UIColor.red
        errorMessageLabel.isHidden = true
        errorMessageLabel.numberOfLines = 0
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setActive()
        
        backgroundView.backgroundColor = UIColor(red: 232/255, green: 241/255, blue: 255/255, alpha: 1.0)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if !nextButton.isActive {
            return
        }
        
        let username = UserDefaults.standard.string(forKey: "username")
        DataStorage.updateUserFields(username: username!, fields: ["major": majorTextField.text!, "year": yearTextField.text!]) { (result) in
            self.performSegue(withIdentifier: "userInfoToMain", sender: self)
        }
    }
    
    func isValidYear() -> Bool {
        return years.contains(yearTextField.text!)
    }
    
    func validateYear() {
        if isValidYear() {
            errorMessageLabel.isHidden = true
            errorMessageLabel.text = ""
            nextButton.setActive()
        }
        else {
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "Year must be \"Freshman\", \"Sophomore\", \"Junior\", \"Senior\", or \"Alumni\""
            nextButton.setInactive()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nextButton.setInactive()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        validateYear()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        majorTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
        
        validateYear()
    }
}
