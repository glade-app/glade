//
//  ArtistsSongsSectionHeader.swift
//  Glade
//
//  Created by Allen Gu on 11/26/20.
//

import UIKit

class ArtistsSongsSectionHeader: UICollectionReusableView {
    var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        var artistsButton: UIButton = {
            let button = UIButton()
            button.setTitle("Top Artists", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        var songsButton: UIButton = {
            let button = UIButton()
            button.setTitle("Top Songs", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
                stack.addArrangedSubview(artistsButton)
        stack.addArrangedSubview(songsButton)
        
        return stack
    }()
    
    var headerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.text = "Here"
        label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(self.horizontalStack)

        NSLayoutConstraint.activate([
            self.horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.horizontalStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0),
            self.horizontalStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0),
            self.horizontalStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(vc: UIViewController) {

    }
}

