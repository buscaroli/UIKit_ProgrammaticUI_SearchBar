//
//  ViewController.swift
//  UIKit_ProgrammaticUI_SearchBar
//
//  Created by Matteo on 31/08/2021.
//

import UIKit

class ViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleView)
        view.addSubview(searchBarView)
        view.addSubview(collectionView)
        
        searchBarView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        picsManager.delegate = self
        
        setupLayout()
        
        
        
    }
    
    var picsManager = PicsManager()
    var pics = PicsModel()
    
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
        sb.placeholder = "Search..."
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
//        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.width / 3.5)
        return CGSize(width: collectionView.frame.width / 1.1, height: collectionView.frame.width / 1.1)
    }
    
    // How many cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.pics.count
        
    }

    // Details of each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.picLabel.text = pics.pics[indexPath.item].getUserName
//        let url = URL(string: pics.pics[indexPath.item].smallPicUrl)!
//        let data = try? Data(contentsOf: url)
//        let img = UIImage(data: data!)
//        cell.backgroundImageView.image = img
        
        let url = URL(string: pics.pics[indexPath.item].smallPicUrl)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print("Error")
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    cell.backgroundImageView = UIImageView(image: UIImage(data: data))
                    print("cellForItemAt \(indexPath.item) : \(self.pics.pics[indexPath.item].smallPicUrl)")
                }
            }
        })

        task.resume()
      
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    // Contents of the searchBar are sent, but only after a delay. This is to prevent sending
    // a request after every character. Better to wait until the user has finished typing.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
            perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
        }

        @objc func reload(_ searchBar: UISearchBar) {
            guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
                print("nothing to search")
                return
            }

            if let term = searchBar.searchTextField.text {
                picsManager.getPics(term)
            } else {
                print("Invalid query.")
            }
        }
}

extension ViewController: PicsManagerDelegate {
    func didUpdatePics(_ pics: PicsModel) {
        DispatchQueue.main.async {
            self.pics = pics
            self.collectionView.reloadData()
            print("~~~ ~~~ ~~~ ~~~ ~~~ ~~~")
            print(pics.pics[0].smallPicUrl)
        }
    }
    
    
}
