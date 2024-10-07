//
//  ContentView.swift
//  NewsApplication
//
//  Created by Ayush on 16/09/24.
//

import SwiftUI
import CoreData

// TODAY

// Home Screen -> Full List Screen -> WebView (Done)
// Select Multiple Categories (Done)
// API for multiple categories (Done)


// FILTER BUTTON + // LAYOUT CHANGE BUTTON (Done)
// THE FILTER OPTIONS WILL OPEN AND CLOSE FOR EVERY CATEGORY (Done)
// CATEGORIES WILL BE MULTIPLE SELECTABLE (Done)

// WHEN TAPPING MULTIPLE SELECTED CATEGORIES (Done)
//   -->> add the selected categories in the array in ViewModel
//   -->> Hit api in group and display the data
//   -->> Change the app layout when anywhere changeLayout button tapped
//   -->> Navigate to Full List
//   -->> Navigate to the WebView with the URL.

// ADDITIONAL -->> When Categories selected change the Scroll to horizontal.


// TOMORROW

//  -->> Add data to Core Data (Done)
//  -->> Display Favorite Listing from CoreData (Done)
//  -->> Save the layout in UserDefaults to show the last used layout (Done)
//  -->> Internet Handling (Done)

// IF GOT TIME -->> Enhancements then Search Section


struct NewsHome: View {
    @StateObject private var viewModel = HomeVM()
    @EnvironmentObject var layoutHandler: LayoutHandler
    @State private var navigateToFavorites = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                HeaderView(title: "News", button1Action: {
                    navigateToFavorites = true
                }, button2Action: {})
                .background(Color.cherryRed)
                .padding(.bottom, 15)
                NavigationLink("", destination: FavoriteView())
                    .opacity(0)
                if navigateToFavorites {
                    NavigationLink(
                        destination: FavoriteView(),
                        isActive: $navigateToFavorites
                    ) {
                        EmptyView()
                    }
                }
                
                HStack(alignment: .top) {
                    FilterDropDown(categories: viewModel.categories, selectedCategories: $viewModel.selectedCategories)
                        .onChange(of: viewModel.selectedCategories) {
                            viewModel.updateNewsListFavoriteStatus()
                        }
                        .padding(.leading, 20)
                    ImageButton(imageName: layoutHandler.isGridView ? "square.split.2x2.fill" : "equal.square.fill", action: {
                        viewModel.updateNewsListFavoriteStatus()
                        layoutHandler.toggleViewLayout()
                    })
                    .padding(.trailing, 12)
                }
                .padding(.bottom, 5)
                Spacer()
                ScrollView(.vertical) {
                    NewsListViewBuilder(viewModel: viewModel)
                        .environmentObject(layoutHandler)
                        .padding(.horizontal, 15)
                }
            }
            .onAppear {
                viewModel.updateNewsListFavoriteStatus()
                viewModel.fetchNews()
           
        }
            .onChange(of: viewModel.isConnected) {
                if viewModel.isConnected {
                    navigateToFavorites = false
                } else {
                    navigateToFavorites = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let layoutHandler = LayoutHandler(layoutManager: UserDefaultsManager())
        NewsHome()
            .environmentObject(layoutHandler)
    }
}
