//
//  ClassifiedDetailsViewController.swift
//  LBC
//
//  Created by Khaled on 31/05/2024.
//

import UIKit

class ClassifiedDetailsViewController: UIViewController {
    let classifiedAd: ClassifiedAd

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

    private lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var urgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Constants.padding / 2
        button.layer.masksToBounds = true
        button.setTitle("Contacter le vendeur", for: .normal)
        
        let textColor = UIColor { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? .orange : .white
        }
        let backgroundColor = UIColor { (trait) -> UIColor in
            return trait.userInterfaceStyle == .dark ? .white : .orange
        }
        button.tintColor = textColor
        button.backgroundColor = backgroundColor
        return button
    }()
    
    init(classifiedAd: ClassifiedAd) {
        self.classifiedAd = classifiedAd
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)

        scrollView.addSubview(adImageView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(urgentLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(contactButton)

        titleLabel.text = classifiedAd.title
        priceLabel.text = "\(classifiedAd.price) \(Constants.currency)"
        categoryLabel.text = "category?.name"
        urgentLabel.text = classifiedAd.isUrgent ? Constants.urgencyText : ""
        descriptionLabel.text = classifiedAd.description
        
        if let imageUrl = classifiedAd.imagesUrl, let thumb = imageUrl.thumb, let imageUrl = URL(string: thumb) {
            Task {
                do {
                    let data = try await APIManager.downloadImageData(from: imageUrl)
                    adImageView.image = UIImage(data: data)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
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
}
