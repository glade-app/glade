//
//  LoginSequenceButton.swift
//  Glade
//
//  Created by Allen Gu on 1/24/21.
//

import Foundation
public class LoginSequenceButton: UIButton {
    let greenColor: UIColor = UIColor(red: 0/255, green: 255/255, blue: 178/255, alpha: 1)
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = greenColor
        self.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.titleLabel!.textAlignment = .center
        self.setTitleColor(.black, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
    
    func setInactive() {
        self.backgroundColor = .gray
    }
    
    func setActive() {
        self.backgroundColor = greenColor
    }
}
