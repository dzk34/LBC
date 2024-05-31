//
//  ClassifiedCell.swift
//  LBC
//
//  Created by Khaled on 31/05/2024.
//

import UIKit

final class ClassifiedCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 5
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        contentView.addSubview(adImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(separatorView)

        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func bind(to classifiedAd: ClassifiedAd) {
        print(classifiedAd.title)
        titleLabel.text = classifiedAd.title
        descriptionLabel.text = classifiedAd.description
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
