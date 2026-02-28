//
//  NetworkHelper.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import Foundation

actor NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private let session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    
    func performDataTask(with urlRequest: URLRequest) async throws -> Data {
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
           throw AppError.noResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw AppError.badStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
    
}

