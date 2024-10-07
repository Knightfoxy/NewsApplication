//
//  WishlistManager.swift
//  NewsApplication
//
//  Created by Ayush on 22/09/24.
//

import Foundation

class WishlistManager {
    static let shared = WishlistManager()
    
    var wishlistId: Set<String> = []
    
    func updateWishlist(_ id: String) {
        if  wishlistId.contains(id) {
            wishlistId.remove(id)
        } else {
            wishlistId.insert(id)
        }
    }
    
    func isWishlisted(_ id: String) -> Bool {
        return wishlistId.contains(id)
    }
}
