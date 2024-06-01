//
//  LBCLabel.swift
//  LBC
//
//  Created by Khaled on 31/05/2024.
//

import UIKit

final class LBCLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension LBCLabel {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title3)
        numberOfLines = 0
    }
}
