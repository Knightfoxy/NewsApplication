//
//  NoDataView.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct NoDataView: View {
    
    var image: String
    var message: String
    
    var body: some View {
           VStack(spacing: 15) {
               Image(systemName:  image)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 30, height: 30)
                   .foregroundColor(.black)
               
               Text(message)
                   .font(.headline)
                   .fontWeight(.medium)
                   .foregroundColor(.black)
                   .multilineTextAlignment(.center)
                   .padding(.horizontal, 20)
           }
       }
}
#Preview {
    NoDataView(image: "wifi.exclamationmark", message: "No Internet !")
}
