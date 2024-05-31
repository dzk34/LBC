//
//  ClassifiedDetailsViewController.swift
//  LBC
//
//  Created by Khaled on 31/05/2024.
//

import UIKit

class ClassifiedDetailsViewController: ViewController {
    let classifiedAd: ClassifiedAd
    let categoryName: String?

    // MARK: Views
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollsToTop = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var adImageView: LBCImageView = {
        let imageView = LBCImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: LBCLabel = {
        let label = LBCLabel()
        label.textColor = .black
        return label
    }()

    private lazy var priceLabel: LBCLabel = {
        let label = LBCLabel()
        label.textColor = .systemOrange
        label.numberOfLines = 1
        return label
    }()

    private lazy var categoryLabel: LBCLabel = {
        let label = LBCLabel()
        label.textColor = .lightGray
        return label
    }()

    private lazy var urgentLabel: LBCLabel = {
        let label = LBCLabel()
        label.textColor = .systemRed
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()

    private lazy var descriptionLabel: LBCLabel = {
        let label = LBCLabel()
        label.textColor = .darkGray
        return label
    }()

    private lazy var dateLabel: LBCLabel = {
        let label = LBCLabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()

    private lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Constants.padding / 2
        button.layer.masksToBounds = true
        button.setTitle("Contacter le vendeur", for: .normal)
        
        let textColor = UIColor { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? .systemOrange : .white
        }
        let backgroundColor = UIColor { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? .white : .systemOrange
        }
        button.tintColor = textColor
        button.backgroundColor = backgroundColor
        return button
    }()
    
    init(classifiedAd: ClassifiedAd, categoryName: String?) {
        self.classifiedAd = classifiedAd
        self.categoryName = categoryName
        super.init(nibName: nil, bundle: nil)
        setupUI()
        fillInData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        view.addSubview(scrollView)

        scrollView.addSubview(adImageView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(urgentLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(contactButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            adImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            adImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            adImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: adImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: Constants.padding / 2),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -Constants.padding / 2),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.padding / 2)
        ])
    }
    
    func fillInData() {
        dateLabel.text = "Posté le \(formatDate(classifiedAd.creationDate))"
        titleLabel.text = classifiedAd.title
        priceLabel.text = "\(classifiedAd.price) \(Constants.currency)"
        categoryLabel.text = categoryName ?? ""
        urgentLabel.text = classifiedAd.isUrgent ? Constants.urgencyText : ""
        descriptionLabel.text = classifiedAd.description
        
        if let imageUrl = classifiedAd.imagesUrl, let thumb = imageUrl.thumb, let imageUrl = URL(string: thumb) {
            adImageView.downloadFrom(url: imageUrl)
        } else {
            adImageView.image = UIImage(named: Constants.noImagePlaceholder)
        }
    }
    
    func formatDate(_ creationDate: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: creationDate) {
            dateFormatter.locale = Locale(identifier: "fr_FR")
            dateFormatter.dateFormat = "dd MMMM yyyy"
//            let newDate = dateFormatter.string(from: Date())
            return dateFormatter.string(from: Date())
        }
        
        return ""
    }
}
