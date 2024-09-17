//
//  ImageButton.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct ImageButton: View {
    let imageName: String
    let action: () -> Void
       
       var body: some View {
           Button(action: {
               action()
           }) {
               Image(systemName: imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 26, height: 26)
                   .padding(10)
                   .cornerRadius(12)
                   .foregroundColor(Color.cherryRed)
                   .contentTransition(.symbolEffect(.replace))
           }
       }
}

#Preview {
    ImageButton(imageName: "plus") {
           print("Button pressed!")
       }
}
