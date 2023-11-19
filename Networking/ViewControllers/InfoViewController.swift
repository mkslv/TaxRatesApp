//
//  MainCollectionViewController.swift
//  Networking
//
//  Created by Max Kiselyov on 11/10/23.
//

import UIKit

final class InfoViewController: UICollectionViewController {
    
    let country: Country
    var taxRates: TaxRates!
    
    private let reuseIdentifier = "Cell"
    
    init(country: Country, collectionViewLayout: UICollectionViewLayout) {
        
        self.country = country
        print("selected country \(self.country)")
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
        self.collectionView!.register(TaxCell.self, forCellWithReuseIdentifier: "\(TaxCell.self)")
        
        NetworkManager.shared.fetchData(countryCodeISO: country.code) { result in
            switch result {
            case .success(let data):
                self.taxRates = data // FIXME: нужно ли использовать список захвата?
                self.collectionView.reloadData()
                self.title = "VAT of \(data.countryName)"
            case .failure(let error):
                print(error.localizedDescription)  // FIXME: Alert controller +
            }
        }
        setupTitle()
    }
}

// MARK: - Layout
private extension InfoViewController {
    func setupTitle() {
        title = "Tax rate"
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
//        return 10
        guard let numberOfRows = taxRates?.otherRates else { return 0 } // TODO: Понять что я делаю с ? знаком
        return numberOfRows.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TaxCell.self)", for: indexPath) as? TaxCell else { return UICollectionViewCell() }
        cell.configure(
            data: indexPath.item < 1 ? taxRates.standardRate : taxRates.otherRates[indexPath.item - 1],
            indexPathItem: indexPath.item,
            backgroundColor: indexPath.item == 0 ? .systemMint : .lightGray
        )
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
        CGSize(width: UIScreen.main.bounds.width - 24, height: 70)
    }
    
}
