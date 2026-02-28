//
//  NewsModal.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let content: String?
    let urlToImage: String?
    let publishedAt: String
    let source: Source
}

struct Source: Codable {
    let name: String
}
