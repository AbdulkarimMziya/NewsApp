//
//  ViewController.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        
        
        loadData()
    }
    
    func loadData() {
        
        Task {
            do {
                // This waits for the array to actually fill up
                let articles = try await NewsService.fetchNewsData(for: "health")
        
                // Always update UI on the MainActor
                DispatchQueue.main.async {
                    print("\(articles.count)")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }


}

