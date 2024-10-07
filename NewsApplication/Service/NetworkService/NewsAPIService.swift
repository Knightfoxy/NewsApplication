//
//  NewsAPIService.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import Foundation
import Combine

class NewsAPIService: APIServiceType {

    var session: URLSession = URLSession.shared
    var baseURL: String
    var bgQueue: DispatchQueue = DispatchQueue.main
    
    init(baseURL: String = "https://newsapi.org/v2") {
        self.baseURL = baseURL
    }

    
    func call<Request>(from endpoint: Request, given queryParams: [String: String]) -> AnyPublisher<Request.ModelType, any Error> where Request : APIRequestType {

        do {
            let request = try endpoint.buildRequest(for: baseURL, queryParams: queryParams)
            print("REUWEST ---->>>", request)
            return session.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIServiceError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIServiceError.httpError(code)
                    }
                    return $0.data
                }
                .decode(type: Request.ModelType.self, decoder: JSONDecoder())
                .mapError {_ in APIServiceError.parseError}
                .receive(on: bgQueue)
                .eraseToAnyPublisher()
        } catch let err {
            print(err)
            return Fail<Request.ModelType, Error>(error: err).eraseToAnyPublisher()
        }
    }
    
    
}

