//
//  APIError.swift
//  RemoteRecruit
//
//  Created by Gourav Joshi on 16/06/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .serverError(let code):
            return "Server returned status code \(code)."
        case .decodingError:
            return "Failed to parse job data."
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}
