//
//  NetworkServicesEnum.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation

struct ServerUrl {
    static let url = "https://jsonplaceholder.typicode.com"
}
enum ApiEndpoint {
    case getUsers

    var endpointString: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
}

extension ApiEndpoint {
    var method: String {
        switch self {
        case .getUsers:
            return "GET"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .getUsers:
            return []
        }
    }

    var httpBody: Data? {
        switch self {
        case .getUsers:
            return nil
        }
    }
}

struct HeaderConfiguration {
    let value: String
    let key: String
}

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
    case emptyData
}
