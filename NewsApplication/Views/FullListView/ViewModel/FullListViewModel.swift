//
//  FullListViewModel.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import Foundation

final class NewsViewModel: ObservableObject {
    
    @Published var favoriteNewsIDs: Set<String> = []
    
    func updateNewsListFavoriteStatus() {
        favoriteNewsIDs = Set(CoreDataManager.shared.fetchFavoriteNewsIDs())
    }
    
    func toggleFavorite(for newsResponse: NewsResponse) {
        guard let id = newsResponse.id else { return }
        
        if favoriteNewsIDs.contains(id) {
            CoreDataManager.shared.deleteNewsById(id: id)
            favoriteNewsIDs.remove(id)
        } else {
            CoreDataManager.shared.saveNews(id: newsResponse.id ?? "", title: newsResponse.name ?? "", description: newsResponse.description ?? "", url: newsResponse.url ?? "")
            favoriteNewsIDs.insert(id)
        }
    }
}
