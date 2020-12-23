//
//  DescriptionViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class DescriptionViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var descriptionPromptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
//    var currentUser = User(displayName: "", email: "", href: "", id: "", images: [Image(height: "", url: "", width: "")], type: "", uri: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setGradientBackground(bottomColor: UIColor(red: 0/255, green: 161/255, blue: 255/255, alpha: 0.3), topColor: UIColor(red: 0/255, green: 255/255, blue: 143/255, alpha: 0.3))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setupItems() {
        // Glade
        gladeNameLabel.text = "Glade"
        //gladeNameLabel.textColor
        gladeNameLabel.font = UIFont.boldSystemFont(ofSize: 72)
        gladeNameLabel.textAlignment = .center
        gladeNameLabel.numberOfLines = 0
        
        // Vertical Stack
        verticalStack.spacing = 20
        
        // Description Prompt
        descriptionPromptLabel.text = "Describe your music taste..."
        //emailPromptLabel.textColor
        descriptionPromptLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        descriptionPromptLabel.textAlignment = .left
        descriptionPromptLabel.numberOfLines = 0
        
        // Text View
        textView.layer.cornerRadius = 20
        textView.backgroundColor = UIColor(red: 0/255, green: 200/255, blue: 0/255, alpha: 0.05)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.systemGreen, for: .normal)
        nextButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nextButton.titleLabel!.textAlignment = .right
    }
    
    func setGradientBackground(bottomColor: UIColor, topColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor]
        gradientLayer.shouldRasterize = true
        backgroundView.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let username = UserDefaults.standard.string(forKey: "username")
        DataStorage.updateUserFields(username: username!,
                                     fields: [description: textView.text!]) { (result) in
            return
        }
        performSegue(withIdentifier: "toConnectSocials", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toConnectSocials" {
//            let socialsVC: SocialsViewController = segue.destination as! SocialsViewController
//        }
//    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        textView.resignFirstResponder()
    }
}
