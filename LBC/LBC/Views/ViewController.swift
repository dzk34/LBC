//
//  ViewController.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    var categories: [Category] = []
    private let requestManager: RequestManagerProtocol

    init(requestManager: RequestManagerProtocol = RequestManager(apiManager: APIManager(), dataParser: DataParser())) { //TODO
        self.requestManager = requestManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = Constants.rowHeight
        view.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        Task {
            await fetchPodcasts()
            tableView.reloadData()
        }

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func fetchPodcasts() async {
        do {
            let categoryList: [Category] = try await requestManager.perform(ClassifiedsRequest.fetchCategories)
            categories = categoryList
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.bind(to: categories[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let vc = CategoryViewController(category: categories[indexPath.row])

        print("selected category: \(categories[indexPath.row].name)")
        navigationController?.pushViewController(vc, animated: true)
    }
}
