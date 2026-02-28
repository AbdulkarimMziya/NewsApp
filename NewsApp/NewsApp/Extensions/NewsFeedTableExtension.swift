//
//  NewsFeedTableExtension.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import Foundation
import UIKit

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellIdentifier, for: indexPath) as! ArticleTableViewCell
        
        let article = newsArticles[indexPath.row]
        
        cell.configure(with: article)
        
        return cell
    }
    
    
}

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = newsArticles[indexPath.row]
        
        let ArticleDetailVC = ArticleDetailViewController(article: article)
        navigationController?.pushViewController(ArticleDetailVC, animated: true)
    }
}
