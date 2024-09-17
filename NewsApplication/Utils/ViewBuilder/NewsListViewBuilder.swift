//
//  NewsListViewBuilder.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct NewsListViewBuilder: View {
    
    @ObservedObject var viewModel: HomeVM
    @EnvironmentObject var layoutViewModel: LayoutHandler
    
    
    @ViewBuilder
    var body: some View {
        if viewModel.selectedCategories.isEmpty {
            createGridOrList(for: viewModel.newsList)
        } else {
            createCategorySections()
        }
    }
    
    @ViewBuilder
    private func createGridOrList(for list: [NewsResponse]) -> some View {
        if layoutViewModel.isGridView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                createNewsItems(for: list)
            }
            .padding(.top, 5)
            .transition(.slide)
        } else {
            LazyVStack {
                createNewsItems(for: list)
            }
            .padding(.top, 5)
            .transition(.slide)
        }
    }
    
    @ViewBuilder
    private func createNewsItems(for list: [NewsResponse]) -> some View {
        ForEach(list) { value in
            NavigationLink(destination: DetailWebView(url: URL(string: value.url ?? "")!)) {
                if layoutViewModel.isGridView {
                    NewsGridView(
                        heading: value.name ?? "",
                        description: value.description ?? "",
                        isFavorite: value.isFavorite,
                        toggleFavorite: { viewModel.toggleFavorite(news: value) }
                    )
                } else {
                    NewsItem(
                        heading: value.name ?? "",
                        description: value.description ?? "",
                        isFavorite: value.isFavorite,
                        toggleFavorite: { viewModel.toggleFavorite(news: value) }
                    )
                }
            }
            .padding(.bottom, 10)
        }
    }
    
    @ViewBuilder
    private func createCategorySections() -> some View {
        if layoutViewModel.isGridView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.selectedCategories, id: \.self) { category in
                    
                    let newsForCategory = Array(viewModel.allCategoryData[category]?.prefix(10) ?? [])
                    let fullNewsList = Array(viewModel.allCategoryData[category] ?? [])
                    
                    Section(header: SectionHeaderView(title: category.rawValue, destination: AnyView(FullListView(newsList: [category.rawValue : fullNewsList])))) {
                        createNewsItems(for: newsForCategory)
                    }
                }
            }
        } else {
            LazyVStack {
                ForEach(viewModel.selectedCategories, id: \.self) { category in
                    let newsForCategory = Array(viewModel.allCategoryData[category]?.prefix(10) ?? [])
                    let fullNewsList = Array(viewModel.allCategoryData[category] ?? [])
                    
                    Section(header: SectionHeaderView(title: category.rawValue, destination: AnyView(FullListView(newsList: [category.rawValue : fullNewsList])))) {
                        createNewsItems(for: newsForCategory)
                    }
                    .padding(.trailing, 10)
                }
            }
        }
    }
}
