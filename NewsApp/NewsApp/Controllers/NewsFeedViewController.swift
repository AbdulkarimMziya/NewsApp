//
//  ViewController.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import UIKit

class NewsFeedViewController: UIViewController {

    // MARK: UI Declarations
    
    private let newsCategoryStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .fillProportionally
        hStack.backgroundColor = .cyan
        // TODO: Add spacing is need
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private let tableview: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 150
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var newsArticles = [Article]() {
        didSet{
            tableview.reloadData()
        }
    }
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        
        loadData()
        setupUI()
    }
    
    func loadData() {
        
        Task {
            do {
                // This waits for the array to actually fill up
                let articles = try await NewsService.fetchNewsData(for: "health")
        
                // Always update UI on the MainActor
                DispatchQueue.main.async {
                    self.newsArticles = articles
                    print("\(articles.count)")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(newsCategoryStack)
        view.addSubview(tableview)
        
        tableview.dataSource = self
        
        // TODO: Implement table delegate
        
        NSLayoutConstraint.activate([
            newsCategoryStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsCategoryStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsCategoryStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsCategoryStack.heightAnchor.constraint(equalToConstant: 40),
            
            tableview.topAnchor.constraint(equalTo: newsCategoryStack.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

