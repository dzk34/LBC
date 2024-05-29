//
//  CategoryViewController.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import UIKit

class CategoryViewController: UIViewController {
    let category: Category?

    init(category: Category?) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        if let category = category {
            print("received category: \(category.name)")
        } else {
            print("no category provided")
        }
    }
}
