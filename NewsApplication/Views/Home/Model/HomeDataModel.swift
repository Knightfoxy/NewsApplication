//
//  HomeDataModel.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import Foundation

struct NewsListResponse: Codable {
    let status: String?
    let sources: [NewsResponse]
}

enum Category: String, CaseIterable, Identifiable, Codable {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    var id: String { self.rawValue }
    
    var caseName: String {
        return String(describing: self)
    }
}

struct NewsResponse : Codable, Identifiable, Hashable {
    let id : String?
    let name : String?
    let description : String?
    let url : String?
    let category : String?
    let language : String?
    let country : String?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case url = "url"
        case category = "category"
        case language = "language"
        case country = "country"
    }
}

