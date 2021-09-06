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
        view.layer.borderColor = UIColor.systemGray.cgColor
        
        return view
    }()
    
    lazy var picLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.textColor = .systemBlue
        
        return label
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 2
        //iv.layer.borderColor = UIColor.systemTeal.cgColor
        iv.clipsToBounds = true
        
        return iv
    }()
    
}


//MARK: - Layout
extension CollectionViewCell {
    private func setupLayout() {
        // When configuring a view, you add any custom subview to self.contentView
        // Option + leftClick for more info!
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(picLabel)
        roundedBackgroundView.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            backgroundImageView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor),
            
            picLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            picLabel.centerYAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self!.backgroundImageView.image = image
                print("~~~~~ ~~~~~ ~~~~~")
                print(self?.backgroundImageView.image ?? "nothing to print here...")
            }
        }).resume()
    }
}
