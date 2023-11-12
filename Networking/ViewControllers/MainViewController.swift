//
//  MViewController.swift
//  Networking
//
//  Created by Max Kiselyov on 11/12/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let countryPicker = UIPickerView()
    private let nextButton = UIButton()
    
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
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(countries[row].code) - \(countries[row].name)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = row
        
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
        
        setupLayout()
    }
}

private extension MainViewController {
    func addSubviews() {
        [countryPicker, nextButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    func setupButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.setTitle("Get tax rates", for: .normal)
        nextButton.setTitleColor(.systemMint, for: .normal)
        nextButton.setTitleColor(.systemMint.withAlphaComponent(0.6), for: .focused)
        nextButton.backgroundColor = .black
    }
    
}

private extension MainViewController {
    func setupLayout() {
        [countryPicker, nextButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            countryPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }
}
