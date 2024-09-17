//
//  FavoriteListViewModel.swift
//  NewsApp
//
//  Created by Ayush on 16/09/24.
//

import Foundation
import CoreData

class FavoriteViewModel: ObservableObject {
    
    @Published var favoriteNewsList: [FavoriteNews] = []
    @Published var isConnected: Bool = true
    private let coreDataManager = CoreDataManager.shared

    
    func isFavorite(newsID: String) -> Bool {
        return CoreDataManager.shared.isNewsSaved(id: newsID)
       }

    func fetchFavoriteNews() {
        favoriteNewsList = coreDataManager.fetchFavoriteNews()
    }

    func deleteFavoriteNews(at id: String) {
        coreDataManager.deleteNewsById(id: id)
        fetchFavoriteNews()
    }
}
