//
//  DescriptionViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class DescriptionViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var descriptionPromptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var placeholderLabel: UILabel!
    @IBOutlet weak var nextButton: LoginSequenceButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    let maxNumWords: Int = 200
//    var currentUser = User(displayName: "", email: "", href: "", id: "", images: [Image(height: "", url: "", width: "")], type: "", uri: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.backgroundView.backgroundColor = UIColor(red: 232/255, green: 241/255, blue: 255/255, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupItems() {
        // Vertical Stack
        verticalStack.spacing = 20
        verticalStack.alignment = .center
        verticalStack.distribution = .fill
        
        // Description Prompt
        descriptionPromptLabel.text = "Tell us about you..."
        //emailPromptLabel.textColor
        descriptionPromptLabel.font = Fonts.getFont(type: .medium, size: 32)
        descriptionPromptLabel.textAlignment = .left
        descriptionPromptLabel.numberOfLines = 0
        
        // Text View
        textView.delegate = self
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        
        // Placeholder Text
        placeholderLabel = UILabel()
        placeholderLabel.text = "Add a bio..."
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 15, y: 15)
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setActive()
        
        // Error Message
        errorMessageLabel.text = ""
        errorMessageLabel.font = Fonts.getFont(type: .regular, size: 14)
        errorMessageLabel.textColor = UIColor.red
        errorMessageLabel.isHidden = true
        errorMessageLabel.numberOfLines = 0
    }
    
    func validateDescription() -> String {
        let description: String = textView.text!
        let numCharacters: Int = description.count
        let numOfNewLines: Int = description.components(separatedBy: ["\n"]).count
        
        // Checks if description is 1) <= 200 characters and 2) has <= 6 lines
        if numCharacters - numOfNewLines > maxNumWords || numOfNewLines > 6 {
            return "Description must contain at most \(maxNumWords) characters and 6 lines"
        }
        return ""
    }
//
//    func countOccurences(s: String, substr: String) -> Int {
//        var count = 0
//        for i in 0...(s.count - substr.count) {
//            for j in 0...substr.count {
//                if s.index(s.startIndex, offsetBy: i + j) != substr.index(substr.startIndex, offsetBy: j) {
//                    continue
//                }
//            }
//            count += 1
//        }
//        return count
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        nextButton.setInactive()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        // Check lines/characters
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let errorMessage = validateDescription()
        if errorMessage != "" {
            errorMessageLabel.text = errorMessage
            errorMessageLabel.isHidden = false
            nextButton.setInactive()
        }
        else {
            errorMessageLabel.text = ""
            errorMessageLabel.isHidden = true
            nextButton.setActive()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if nextButton.isActive == false {
            return
        }
        let username = UserDefaults.standard.string(forKey: "username")
        DataStorage.updateUserFields(username: username!,
                                     fields: ["description": textView.text!]) { (result) in
            self.performSegue(withIdentifier: "toUserInfo", sender: self)
        }
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        textView.resignFirstResponder()
    }
}
