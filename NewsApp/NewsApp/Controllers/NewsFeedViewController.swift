//
//  ViewController.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import UIKit

class NewsFeedViewController: UIViewController {

    // MARK: UI Declarations
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["General", "Tech", "Sports", "Health"]
        let control = UISegmentedControl(items: items)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0 // Set the default selected segment
        control.addTarget(self, action:#selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return control
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
        view.backgroundColor = .white
        
        loadData(with: "General")
        setupUI()
    }
    
    func loadData(with category: String) {
        
        Task {
            do {
                // This waits for the array to actually fill up
                let articles = try await NewsService.fetchNewsData(for: category)
        
                // Always update UI on the MainActor
                DispatchQueue.main.async {
                    self.newsArticles = articles
                    self.title = category
                    print("\(articles.count)")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(tableview)
        
        tableview.dataSource = self
        
        // TODO: Implement table delegate
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableview.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let category = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
            return
        }
        
        loadData(with: category)
    }



}

