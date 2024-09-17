//
//  NewsItem.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct NewsItem: View {
    let heading: String
    let description: String
    @State var isFavorite: Bool
    let toggleFavorite: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 20) {
                Image(systemName: "heart.text.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .cornerRadius(12)
                    .foregroundColor(Color.gray)
                VStack(alignment: .leading, spacing: 8) {
                    Text(heading)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
            Button(action: {
                toggleFavorite()
                isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 24)
            }
            .padding()
            .foregroundColor(isFavorite ? Color.darkYellow : Color.gray)
        }
    }
}


struct NewsItem_Previews: PreviewProvider {
    @State static private var isFavorite: Bool = true

    static var previews: some View {
        NewsItem(
            heading: "Heading",
            description: "Description",
            isFavorite: isFavorite,
            toggleFavorite: {
                isFavorite.toggle()
            }
        )
    }
}
