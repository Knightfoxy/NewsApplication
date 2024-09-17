//
//  APIServiceType.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import Foundation
import Combine

protocol APIServiceType {
    var session: URLSession {get}
    var baseURL: String {get}
    var bgQueue: DispatchQueue {get}
    func call<Request>(from endpoint: Request, given queryParams: [String: String] ) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType
}

