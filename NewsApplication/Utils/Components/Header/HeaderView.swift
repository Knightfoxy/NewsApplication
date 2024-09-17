//
//  HeaderView.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var button1Action: () -> Void
    var button2Action: () -> Void
    var button1Icon: String = "star"
    var button2Icon: String = "magnifyingglass"
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
            
            HStack(spacing: 20) {
                NavigationLink(destination: FavoriteView()) {
                    Button(action: button1Action) {
                        Image(systemName: button1Icon)
                            .font(.title2)
                            .foregroundColor(Color.white)
                    }
                }
                Button(action: button2Action) {
                    Image(systemName: button2Icon)
                        .font(.title2)
                        .foregroundColor(Color.white)
                }
            }
        }
        .padding(20)
//        .background(Color.white.opacity(0.4))
    }
}

#Preview {
    HeaderView(title: "Heading", button1Action: {}, button2Action: {})
}
