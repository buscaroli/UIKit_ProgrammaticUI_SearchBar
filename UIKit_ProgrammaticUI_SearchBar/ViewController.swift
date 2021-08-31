//
//  ViewController.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 31/08/2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleView)
        view.addSubview(searchBarView)
        view.addSubview(collectionView)
        
        searchBarView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupLayout()
        
        
    }
    
    var picNames: [String] = [
        "Puppy",
        "Cats",
        "Joyful kittens",
        "Happy cubs",
        "Meeeouww!",
        "Woof woof",
        "Bark Bark",
        "Squeeze me!"
    ]
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.widthAnchor.constraint(equalTo: view.widthAnchor),

            searchBarView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    let titleView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        // tv.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        tv.font = UIFont(name: "Georgia-Italic", size: 44)
        tv.textColor = .systemBlue
        tv.textAlignment = .center
        tv.text = "Coins Live"
        tv.sizeToFit()
                
        return tv
    }()
    
    
    let searchBarView: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.searchBarStyle = .default
        sb.placeholder = "Filter coins..."
        sb.sizeToFit()
        sb.isTranslucent = false
        sb.showsCancelButton = false
                
        return sb
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 10,
                                           bottom: 0,
                                           right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemYellow
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        return cv
    }()

    
}

//MARK: - Extension UICollectionView

extension ViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Dimensions of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.width / 3.5)
    }
    
    // How many cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picNames.count
        
    }

    // Details of each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = .systemTeal
        cell.picLabel.text = picNames[indexPath.item]
        
        return cell
    }
    
    
    
}
