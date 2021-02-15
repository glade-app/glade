//
//  LoginSequenceButton.swift
//  Glade
//
//  Created by Allen Gu on 1/24/21.
//

import Foundation
public class LoginSequenceButton: UIButton {
    let greenColor: UIColor = UIColor(red: 0/255, green: 255/255, blue: 178/255, alpha: 1)
    
    public enum LoginButtonStyle: String {
        case normal = "normal"
        case unfilled = "unfilled"
    }
    
    public var isActive: Bool = true
    private var currentStyle: LoginButtonStyle = .normal
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        self.setStyle(style: .normal)
        self.titleLabel!.font = Fonts.getFont(type: .bold, size: 18)
        self.titleLabel!.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = self.bounds.size.height / 4
    }
    
    func setStyle(style: LoginButtonStyle) {
        if style == .normal {
            self.backgroundColor = greenColor
            self.setTitleColor(.black, for: .normal)
            self.currentStyle = .normal
        }
        else if style == .unfilled {
            self.backgroundColor = .clear
            self.setTitleColor(.black, for: .normal)
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
            self.currentStyle = .unfilled
        }
    }
    
    func setInactive() {
        isActive = false
        self.backgroundColor = .gray
    }
    
    func setActive() {
        isActive = true
        if (currentStyle == .normal) {
            self.setStyle(style: .normal)
        }
        else if (currentStyle == .unfilled) {
            self.setStyle(style: .unfilled)
        }
    }
}
