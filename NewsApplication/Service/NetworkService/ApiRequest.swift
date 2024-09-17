//
//  ApiRequest.swift
//  NewsApplication
//
//  Created by Ayush on 16/09/24.
//
import Foundation

protocol APIRequestType {
    associatedtype ModelType: Decodable
    
    var path: String {get}
    var method: String {get}
    var headers: [String: String]? {get}
//    var queryItems: [String: String]? {get}
    func body() throws -> Data?
}

extension APIRequestType {
    func buildRequest(for baseUrl: String, queryParams: [String: String]? = nil) throws -> URLRequest {
        guard let url = URL(string: baseUrl + path) else {
            throw APIServiceError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!

        if let params = queryParams {
            var queryItems: [URLQueryItem] = []
            for (key, value) in params {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            components.queryItems = queryItems
        }

        guard let finalUrl = components.url else {
            throw APIServiceError.invalidURL
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        
        return request
    }
}

struct NewsListRequest: APIRequestType {
    typealias ModelType = NewsListResponse
    
    var path: String
    var method: String { return "GET" }
    var headers: [String: String]? { return ["Content-Type": "application/json"] }
    func body() throws -> Data? {
        return Data()
    }
}
