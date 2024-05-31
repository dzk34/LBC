//
//  ClassifiedCell.swift
//  LBC
//
//  Created by Khaled on 31/05/2024.
//

import UIKit

final class ClassifiedCell: UICollectionViewCell {
    
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

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.numberOfLines = 2
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
        label.numberOfLines = 1
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        contentView.addSubview(adImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(urgentLabel)
        contentView.addSubview(separatorView)

        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0

        NSLayoutConstraint.activate([
            adImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            adImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            adImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: adImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding / 2),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding / 2),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding / 2)
        ])
    }
    
    func bind(to classifiedAd: ClassifiedAd, category: Category?) {
        print(classifiedAd.title)
        titleLabel.text = classifiedAd.title
        priceLabel.text = "\(classifiedAd.price) \(Constants.currency)"
        categoryLabel.text = category?.name
        urgentLabel.text = classifiedAd.isUrgent ? Constants.urgencyText : ""
        

        if let imageUrl = classifiedAd.imagesUrl, let small = imageUrl.small, let imageUrl = URL(string: small) {
            Task {
                do {
                    let data = try await APIManager.downloadImageData(from: imageUrl)
                    adImageView.image = UIImage(data: data)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
