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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        
        let article = newsArticles[indexPath.row]
        
        
        cell.textLabel?.text = article.source.name
        
        return cell
    }
    
    
}
