//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import Foundation
import UIKit

struct NewsService {

    // 1. Mark the function as 'async' and 'throws'
    static func fetchNewsData(for category: String?) async throws -> [Article] {
        
        // Create the url Components (Your logic is perfect here)
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        
        var queryItems = [URLQueryItem(name: "country", value: "us")]
        if let category {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        queryItems.append(URLQueryItem(name: "apiKey", value: Secret.apiKey))
        components.queryItems = queryItems
        
        // 2. Validate URL and Create Request
        guard let url = components.url else {
            throw AppError.badURL(components.string ?? "")
        }
        let request = URLRequest(url: url)
        
        // 3. Use your NetworkHelper (No 'Task' block needed inside the function)
        let data = try await NetworkHelper.shared.performDataTask(with: request)
        
        // 4. Decode the data
        var newsArticles = [Article]()
        var newsResponse: NewsResponse
        do{
            let decoder = JSONDecoder()
            newsResponse = try decoder.decode(NewsResponse.self, from: data)
        } catch {
            throw AppError.decodingError(error)
        }
        
        newsArticles = newsResponse.articles
        
        return newsArticles
    }
    
    static func fetchImage(from urlString: String?) async throws -> UIImage? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        
        let data = try await NetworkHelper.shared.performDataTask(with: request)
        
        guard let image = UIImage(data: data) else {
            throw AppError.noData
        }
        
        return image
    }
}
