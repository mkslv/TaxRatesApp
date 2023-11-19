//
//  MViewController.swift
//  Networking
//
//  Created by Max Kiselyov on 11/12/23.
//

import UIKit

final class MainViewController: UIViewController {
    private let infoLabel = UILabel()
    private let countryPicker = UIPickerView()
    private let nextButton = UIButton()
//    private lazy var alertController = UIAlertController()
    
    private let countries = Country.getListOfCountries()
    private var selectedCountry = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.delegate = self

        setupView()
    }
    
    @objc
    func nextButtonTapped() {
        let nextVC = InfoViewController(country: countries[selectedCountry], collectionViewLayout: UICollectionViewLayout())
        // тут передать данные какая страна
        navigationController?.pushViewController(nextVC, animated: true)
//        present(alertController, animated: true) {
//            print(#function)
//        }
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(countries[row].code)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = row
        print("\(selectedCountry) - \(countries[row])")
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
}

private extension MainViewController {
    func setupView() {
        addSubviews()
        view.backgroundColor = .systemBackground
        setupButton()
        setupLabel()
        
        setupLayout()
    }
}

private extension MainViewController {
    func addSubviews() {
        [infoLabel, countryPicker, nextButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    func setupButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.setTitle("Get tax rates", for: .normal)
        nextButton.setTitleColor(.systemMint, for: .normal)
        nextButton.setTitleColor(.systemMint.withAlphaComponent(0.6), for: .focused)
        nextButton.backgroundColor = .black
        nextButton.layer.cornerRadius = 30
    }
    
    func setupLabel() {
        infoLabel.text = "Choose the country and get info about VAT and Sales Taxes in the region"
        infoLabel.numberOfLines = 0
    }
    
//    func setupAlertController() {
//        alertController.title = "Error"
//        alertController.message = "Something went wrong"
//        let okButton = UIAlertAction(title: "Ok", style: .default)
//        alertController.addAction(okButton)
//    }
}

private extension MainViewController {
    func setupLayout() {
        [infoLabel, countryPicker, nextButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            countryPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryPicker.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 100),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: countryPicker.bottomAnchor, constant: 100),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
