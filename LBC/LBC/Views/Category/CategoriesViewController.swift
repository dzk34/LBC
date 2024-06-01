//
//  CategoriesViewController.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import UIKit
//import Combine

class CategoriesViewController: ViewController {
    // MARK: Properties
    private let cellId = "CategoryCell"
    
    @InjectedDependency(\.categoriesViewModel) var categoriesViewModel: CategoriesViewModel
    var categories: [Category] = []


    // MARK: Views
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        Task {
            await loadData()
            collectionView.reloadData()
        }
    }

    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width * 0.8, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
    }
    
    func loadData() async {
        categories = await categoriesViewModel.fetchCategories()
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.bind(to: categories[indexPath.row])
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ClassifiedsViewController(category: categories[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
