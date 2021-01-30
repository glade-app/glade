//
//  LoginSequenceButton.swift
//  Glade
//
//  Created by Allen Gu on 1/24/21.
//

import Foundation
public class LoginSequenceButton: UIButton {
    let greenColor: UIColor = UIColor(red: 0/255, green: 255/255, blue: 178/255, alpha: 1)
    
    public var isActive: Bool = true
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = greenColor
        self.titleLabel!.font = Fonts.getFont(type: .bold, size: 18)
        self.titleLabel!.textAlignment = .center
        self.setTitleColor(.black, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = self.bounds.size.height / 4
        
    }
    
    func setInactive() {
        isActive = false
        self.backgroundColor = .gray
    }
    
    func setActive() {
        isActive = true
        self.backgroundColor = greenColor
    }
}
