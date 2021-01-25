//
//  LoginSequenceTextField.swift
//  Glade
//
//  Created by Allen Gu on 1/24/21.
//

import Foundation

public class LoginSequenceTextField: UITextField {
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.addBottomBorder()
    }
    
    func addBottomBorder() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 7, width: self.frame.size.width, height: 2)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        self.layer.addSublayer(bottomBorder)
    }
}
