//
//  SectionHeaderView.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var destination: AnyView

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: destination) {
                    HStack {
                        Text(title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .scaleEffect(1.0)
                            .foregroundColor(Color.gray)
                    }
                    .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, 20)
            
            Divider()
                .padding(.leading, 20)
        }
    }
}
#Preview {
    SectionHeaderView(title: "Heading", destination: AnyView(Text("Detail View")))
}
