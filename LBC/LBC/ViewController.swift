//
//  ViewController.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categories = MockData().categories
        print("\(categories.count) -> \(categories)")
    }
}
