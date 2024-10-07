//
//  FullListView.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct FullListView: View {
    
    // MARK: - Properties
    @State var newsList: [String: [NewsResponse]]
    @EnvironmentObject var layoutHandler: LayoutHandler
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                if layoutHandler.isGridView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(newsList.values.flatMap { $0 }, id: \.self) { value in
                            NavigationLink(destination: DetailWebView(url: URL(string: value.url ?? "")!)) {
                                NewsGridView(heading: value.name ?? "", description: value.description ?? "", isFavorite: value.isFavorite, toggleFavorite: {
                                    viewModel.toggleFavorite(for: value)
                                    updateNewsListFavoriteStatus()
                                })
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.top, 15)
                    .padding(.horizontal, 15)
                } else {
                    LazyVStack {
                        ForEach(newsList.values.flatMap { $0 }, id: \.self) { value in
                            NavigationLink(destination: DetailWebView(url: URL(string: value.url ?? "")!)) {
                                NewsItem(heading: value.name ?? "", description: value.description ?? "", isFavorite: value.isFavorite ?? false, toggleFavorite: {
                                    viewModel.toggleFavorite(for: value)
                                    updateNewsListFavoriteStatus()
                                })
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.top, 15)
                    .padding(.horizontal, 15)
                }
            }
        }
        .navigationTitle(navigationTitle)
        .onAppear {
            viewModel.updateNewsListFavoriteStatus()
            updateNewsListFavoriteStatus()
        }
        .onChange(of: viewModel.favoriteNewsIDs) {
            updateNewsListFavoriteStatus()
        }
    }
    
    private var navigationTitle: String {
        guard let title = newsList.keys.first else { return "Categorical List" }
        return "Category: \(title)"
    }
    
    private func updateNewsListFavoriteStatus() {
        for (key, var newsArray) in newsList {
            newsArray = newsArray.map { news in
                var updatedNews = news
                updatedNews.isFavorite = viewModel.favoriteNewsIDs.contains(news.id ?? "")
                return updatedNews
            }
            newsList[key] = newsArray
        }
    }
}

// MARK: - Preview

#Preview {
    FullListView(newsList: [:])
}
