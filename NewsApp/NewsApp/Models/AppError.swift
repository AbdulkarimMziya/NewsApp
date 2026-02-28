//
//  AppError.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import Foundation


enum AppError: Error {
    case badURL(String)
    case noResponse
    case requestFailed(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
}
