//
//  FavoriteNewsView.swift
//  NewsApp
//
//  Created by Ayush on 16/09/24.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @EnvironmentObject var layoutHandler: LayoutHandler
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.medium)
                            
                    }
                    Spacer()
                    Text("Favorites")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .padding()
                .padding(.bottom, 10)
                .background(Color.cherryRed)
                .shadow(radius: 2)
                if viewModel.favoriteNewsList.isEmpty {
                    NoDataView(image: "star", message: "No favorites present!")
                        .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        
                        if layoutHandler.isGridView {
                            LazyVGrid(columns: [GridItem(), GridItem()]) {
                                ForEach(viewModel.favoriteNewsList, id: \.self) { value in
                                    NavigationLink(destination: DetailWebView(url: URL(string: value.url ?? "")!)) {
                                        NewsGridView(heading: value.name ?? "", description: value.description ?? "", isFavorite: true,   toggleFavorite: {
                                            viewModel.deleteFavoriteNews(at: value.id!)
                                            if let check = value.id {
                                                WishlistManager.shared.updateWishlist(check)
                                                print(WishlistManager.shared.wishlistId)
                                            }
                                        })
                                        .padding(.bottom, 10)
                                    }
                                }
                            }
                            .padding(.top, 15)
                            .padding(.horizontal, 15)
                        } else {
                            
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(viewModel.favoriteNewsList, id: \.self) { news in
                                    NavigationLink(destination: DetailWebView(url: URL(string: news.url ?? "")!)) {
                                        NewsItem(
                                            heading: news.name ?? "title",
                                            description: news.description ?? "",
                                            isFavorite: true,
                                            toggleFavorite: {
                                                viewModel.deleteFavoriteNews(at: news.id!)
                                                if let check = news.id {
                                                    WishlistManager.shared.updateWishlist(check)
                                                    print(WishlistManager.shared.wishlistId)
                                                }
                                            }
                                        )
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchFavoriteNews()
            }
            .onChange(of: viewModel.isConnected) {
                print("Network status changed: \(viewModel.isConnected)")
                viewModel.fetchFavoriteNews()
            }
        }
        .navigationBarHidden(true)
    }
}
