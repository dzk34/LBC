//
//  ClassifiedsViewController.swift
//  LBC
//
//  Created by Khaled on 30/05/2024.
//

import UIKit

class ClassifiedsViewController: UIViewController {
    var classifiedAd: [ClassifiedAd] = []
    private var viewModel: ClassifiedsViewModel

    let category: Category?

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = Constants.rowHeight
        view.register(ClassifiedCell.self, forCellReuseIdentifier: "ClassifiedCell")
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
                tableView.reloadData()
            } else {
                print("no category")
            }
        }
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

    }
    
    func loadData() async {
        classifiedAd = await viewModel.fetchClassifieds()
    }
}

extension ClassifiedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        classifiedAd.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassifiedCell") as! ClassifiedCell
        cell.bind(to: classifiedAd[indexPath.row])
        return cell
    }
}

extension ClassifiedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
//        let vc = CategoryViewController(category: classifiedAd[indexPath.row])
//        navigationController?.pushViewController(vc, animated: true)
    }
}
