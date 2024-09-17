//
//  FilterDropDown.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import SwiftUI

struct FilterDropDown: View {
    
    let categories: [Category]
    @State private var isExpanded = false
    @Binding var selectedCategories: [Category]
    
    var body: some View {
        ZStack(alignment: .center) {
            
            VStack {
                Button(action: {
                    isExpanded.toggle()
                }) {
                    
                    VStack {
                        HStack {
                            Text("Filter by Categories")
                                .foregroundColor(Color.black)
                                .font(.headline)
                            Spacer()
                            
                            Image(systemName: !isExpanded ? "chevron.down" : "chevron.up")
                                .scaleEffect(1.1)
                                .contentTransition(.symbolEffect(.replace))
                                .foregroundColor(Color.black)
                        }
                        .padding(16)
                        .cornerRadius(12)
                    }
                    
                }
                
                // LISTING OF CATEGORIES
                if isExpanded {
                    VStack(alignment: .center) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                toggleCategory(category)
                            }) {
                                Text(category.rawValue)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(isSelected(category) ? Color.cherryRed : Color.gray.opacity(0.1))
                                    .foregroundColor(isSelected(category) ? Color.white : Color.black)
                                    .font(isSelected(category) ? .headline: .headline)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 0.8)
            )
            
            //       UNTAPPABLE IMAGE -> TOGGLE THE ICON TO MINUS
            //            Image(systemName: "plus.square")
            //                .frame(width: 20, height: 20)
            //                .background(Color.white)
        }
    }
    
    private func isSelected(_ category: Category) -> Bool {
        return selectedCategories.contains(category)
    }
    
    private func toggleCategory(_ category: Category) {
        if let index = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(category)
        }
        print("selectedCategories", selectedCategories)
    }
}

#Preview {
    FilterDropDown(categories: [Category.business, Category.entertainment, Category.general], selectedCategories: .constant([.business]))
}
