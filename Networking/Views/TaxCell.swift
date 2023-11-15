//
//  CountdownTableViewCell.swift
//  Final project
//
//  Created by Max Kiselyov on 10/31/23.
//

import UIKit

final class TaxCell: UICollectionViewCell {
    // MARK: - Properties
    private let numberLabel = UILabel()
    private let classLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let rateLabel = UILabel()
    private let commentTaxRateLabel = UILabel()
    
    private let rateMaskView = UIView()
    
    private let nameContainer = UIStackView()
    private let numberAndNameContainer = UIStackView()
    private let rateContainer = UIStackView()
        
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(data: Rate, indexPathItem: Int, backgroundColor: UIColor) {
        numberLabel.text = String(indexPathItem + 1)
        classLabel.text = data.classRate
        descriptionLabel.text = data.types ?? data.descriptionOfTax
        rateLabel.text = "\(String(format: "%.2f", data.rate))%"
        self.backgroundColor = backgroundColor
        commentTaxRateLabel.text = "Tax rate"
    }
}

// MARK: - Setup View
private extension TaxCell {
    func setupView() {
        addSubviews()
        self.layer.cornerRadius = 20 
        setupLabels()
        
        setupVerticalContainer(for: nameContainer, primaryLabel: classLabel, secondaryLabel: descriptionLabel)
        setupVerticalContainer(for: rateContainer, primaryLabel: rateLabel, secondaryLabel: commentTaxRateLabel)
        
        setupHorizontalContainer()
        setupThintView()
        
        setupLayout()
    }
}
// MARK: - Settings
private extension TaxCell {
    func addSubviews() {
        [nameContainer, rateContainer, numberAndNameContainer, rateMaskView, rateContainer].forEach { subView in
            addSubview(subView)
        }
    }
    
    func setupLabels() {
        numberLabel.font = .systemFont(ofSize: 20)
        numberLabel.textColor = .white
        
        [classLabel, rateLabel].forEach { label in
            label.font = .boldSystemFont(ofSize: 20)
        }
        
        [descriptionLabel, commentTaxRateLabel].forEach { label in
            label.font = .preferredFont(forTextStyle: .footnote)
            label.numberOfLines = 2
        }
        
        [classLabel, descriptionLabel, rateLabel, commentTaxRateLabel].forEach { label in
            label.textColor = .white
        }
    }
    
    func setupThintView() {
        rateMaskView.backgroundColor = .black.withAlphaComponent(0.40)
        rateLabel.textAlignment = .center
        commentTaxRateLabel.textAlignment = .center
        layer.cornerRadius = 12
    }
    
    func setupVerticalContainer(for container: UIStackView, primaryLabel: UILabel, secondaryLabel: UILabel) {
        container.axis = .vertical
        container.spacing = 6
        [primaryLabel, secondaryLabel].forEach { view in
            container.addArrangedSubview(view)
        }
    }
    
    func setupHorizontalContainer() {
        numberAndNameContainer.axis = .horizontal
        numberAndNameContainer.spacing = 10
        
        [numberLabel, nameContainer].forEach { view in
            numberAndNameContainer.addArrangedSubview(view)
        }
    }
}
// MARK: - Layout
private extension TaxCell {
    func setupLayout() {
        clipsToBounds = true // растягиваем по всей возможной площади
        
        [numberAndNameContainer, rateMaskView, rateContainer].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: 70),
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20), 
            
            numberAndNameContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            numberAndNameContainer.trailingAnchor.constraint(lessThanOrEqualTo: rateMaskView.leadingAnchor, constant: -1),
            numberAndNameContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rateMaskView.topAnchor.constraint(equalTo: topAnchor),
            rateMaskView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateMaskView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rateMaskView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            
            rateContainer.centerXAnchor.constraint(equalTo: rateMaskView.centerXAnchor),
            rateContainer.centerYAnchor.constraint(equalTo: rateMaskView.centerYAnchor),
        ])
    }
}


