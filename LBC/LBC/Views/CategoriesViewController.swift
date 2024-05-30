//
//  CategoriesViewController.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import UIKit
import Combine

class CategoriesViewController: UIViewController {
    var categories: [Category] = []
    private var viewModel: CategoriesViewModel


    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - Constants.padding, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)

        Task {
            await loadData()
            collectionView.reloadData()
        }
    }

    func loadData() async {
        categories = await viewModel.fetchCategories()
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.bind(to: categories[indexPath.row])
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryViewController(category: categories[indexPath.row])

        print("selected category: \(categories[indexPath.row].name)")
        navigationController?.pushViewController(vc, animated: true)
    }
}
