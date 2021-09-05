//
//  CollectionViewCell.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 31/08/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    //MARK: - Properties
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemTeal.cgColor
        
        return view
    }()
    
    lazy var picLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.textColor = .systemIndigo
        
        return label
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.systemTeal.cgColor
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
}


//MARK: - Layout
extension CollectionViewCell {
    private func setupLayout() {
        // When configuring a view, you add any custom subview to self.contentView
        // Option + leftClick for more info!
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(picLabel)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            picLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            picLabel.centerYAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }
}
