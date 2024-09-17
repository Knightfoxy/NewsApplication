//
//  HomeVM.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import Foundation
import Combine

class HomeVM: ObservableObject {
    
    @Published var categories: [Category] = Category.allCases
    @Published var errorMessage: String? = nil
    @Published var newsList: [NewsResponse] = []
    @Published var allCategoryData: [Category: [NewsResponse]] = [:]
    @Published var isConnected: Bool = true
    @Published var selectedCategories: [Category] = [] {
        didSet {
            if !selectedCategories.isEmpty {
                fetchCategoriesData()
            }
        }
    }
    private let newsService = NewsAPIService()
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    private var cancellables: [AnyCancellable] = []
    private var networkMonitor = NetworkManager()

    init() {
        networkMonitor.$isConnected
            .assign(to: &$isConnected)
    }
    
    func fetchNews() {
        let queryParams: [String: String] = {
            return ["apiKey": "879f3ad65e90447db46f08eee794dcd5"]
        }()
        let endpoint = NewsListRequest(path: "/top-headlines/sources?")
        
        newsService.call(from: endpoint, given: queryParams)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { newsSources in
                DispatchQueue.main.async {
                    self.newsList = newsSources.sources
                    self.updateNewsListFavoriteStatus()
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchCategoriesData() {
        let dispatchGroup = DispatchGroup()
        var categoryData: [Category: [NewsResponse]] = [:]
        
        for category in selectedCategories {
            dispatchGroup.enter()
            
            fetchParticularCategoryData(having: category)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        break
                    }
                    dispatchGroup.leave()
                }, receiveValue: { newsResponse in
                    categoryData[category] = newsResponse.sources
                    print(categoryData)
                })
                .store(in: &cancellables)
            
            dispatchGroup.notify(queue: .main) {
                self.allCategoryData = categoryData
            }
        }
    }
    
    private func fetchParticularCategoryData(having category: Category) -> AnyPublisher<NewsListResponse, Error> {
        let queryParams: [String: String] = [
            "category": category.caseName,
            "apiKey": "879f3ad65e90447db46f08eee794dcd5"
            //                "663988f253f1419a821b9d2675e120b0"
        ]
        let endpoint = NewsListRequest(path: "/top-headlines/sources")
        
        return newsService.call(from: endpoint, given: queryParams)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func isFavorite(newsID: String) -> Bool {
        return CoreDataManager.shared.isNewsSaved(id: newsID)
    }
    
    func toggleFavorite(news: NewsResponse) {
        guard let id = news.id else { return }
        
        if isFavorite(newsID: news.id ?? "") {
            CoreDataManager.shared.deleteNewsById(id: id)
        } else {
            CoreDataManager.shared.saveNews(
                id: id,
                title: news.name ?? "No Title",
                description: news.description ?? "No Description",
                url: news.url ?? ""
            )
        }
    }
    
    func updateNewsListFavoriteStatus() {
        let arrayOfFavIds = CoreDataManager.shared.fetchFavoriteNewsIDs()
        newsList = newsList.map { newsItem in
            var updatedNewsItem = newsItem
            updatedNewsItem.isFavorite = arrayOfFavIds.contains(newsItem.id ?? "")
            return updatedNewsItem
        }
        allCategoryData = allCategoryData.mapValues { newsResponses in
            newsResponses.map { newsResponse in
                var updatedNewsResponse = newsResponse
                updatedNewsResponse.isFavorite = arrayOfFavIds.contains(newsResponse.id ?? "")
                return updatedNewsResponse
            }
        }
    }
}

