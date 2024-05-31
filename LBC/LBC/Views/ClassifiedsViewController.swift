//
//  ClassifiedsViewController.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import UIKit

class ClassifiedsViewController: ViewController {
    let cellId = "ClassifiedCell"
    var classifiedAd: [ClassifiedAd] = []
    private var viewModel: ClassifiedsViewModel

    let category: Category?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.width / 2, height: 180)
//        layout.minimumInteritemSpacing = Constants.padding
        layout.minimumLineSpacing = Constants.padding

        let view = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        view.register(ClassifiedCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()

    init(viewModel: ClassifiedsViewModel, category: Category?) {
        self.viewModel = viewModel
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        Task {
            await loadData()
            if let category = category {
                classifiedAd.removeAll { $0.categoryId != category.id}
                collectionView.reloadData()
            } else {
                print("no category")
            }
        }
    }

    func setupUI() {
        view.addSubview(collectionView)

//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
//        ])
    }
    
    func loadData() async {
        classifiedAd = await viewModel.fetchClassifieds()
    }
}

extension ClassifiedsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        classifiedAd.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClassifiedCell

        cell.bind(to: classifiedAd[indexPath.row], category: category)
        return cell
    }
}

extension ClassifiedsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: Constants.padding, bottom: 1.0, right: Constants.padding)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - Constants.padding, height: widthPerItem * 2)
    }
}

extension ClassifiedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item")
        let vc = ClassifiedDetailsViewController(classifiedAd: classifiedAd[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
