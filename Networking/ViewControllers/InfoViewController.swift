//
//  MainCollectionViewController.swift
//  Networking
//
//  Created by Max Kiselyov on 11/10/23.
//

import UIKit

final class InfoViewController: UICollectionViewController {
    
    let country: Country
    
    private let reuseIdentifier = "Cell"
    
    init(country: Country, collectionViewLayout: UICollectionViewLayout) {
        
        self.country = country
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // setup layout
        collectionView.collectionViewLayout = setupFlowLayout()
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        NetworkManager.shared.fetchData(countryCodeISO: country.code)
        
        setupTitle()
    }
    
    
}

// MARK: - Layout
private extension InfoViewController {
    func setupTitle() {
        title = "Hello"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    // Create a UICollectionViewFlowLayout
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
//        layout.estimatedItemSize = CGSize(width: 100, height: 50)
//        layout.itemSize = CGSize(width: 100, height: 50)
        
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension InfoViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .lightGray
        // Configure the cell
        cell.layer.cornerRadius = 20
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension InfoViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

}

// MARK: - UICollectionViewDelegateFlowLayout
extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 24, height: 100)
    }
    
}
