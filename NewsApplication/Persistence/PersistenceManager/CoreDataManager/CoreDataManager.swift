//
//  CoreDataManager.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//

import Foundation

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "FavoriteNews")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error in init coredata: \(error)")
            }
        }
    }
    
    // MARK: - Check if News is already saved
    func isNewsSaved(id: String) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to check if news is saved: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Save Data
    func saveNews(id: String, title: String, description: String, url: String) {
        if isNewsSaved(id: id) {
            print("News already saved!")
            return
        }
        
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let favoriteNews = FavoriteNews(context: backgroundContext)
            favoriteNews.id = id
            favoriteNews.title = title
            favoriteNews.desc = description
            favoriteNews.url = url
            
            do {
                try backgroundContext.save()
                print("News saved successfully.")
            } catch {
                print("Failed to save news: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Fetch Data
    func fetchFavoriteNews() -> [FavoriteNews] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorite news: \(error)")
            return []
        }
    }
    
    // MARK: - Delete Data
    func deleteNewsById(id: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try context.fetch(fetchRequest)
            if let newsToDelete = results.first {
                context.delete(newsToDelete)
                try context.save()
                print("News deleted successfully!")
            }
        } catch {
            print("Failed to delete news by id: \(error)")
        }
    }
    
    func fetchFavoriteNewsIDs() -> [String] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest()
        
        do {
            let favoriteNewsItems = try context.fetch(fetchRequest)
            let favoriteNewsIDs = favoriteNewsItems.compactMap { $0.id }
            return favoriteNewsIDs
        } catch {
            print("Failed to fetch favorite news: \(error)")
            return []
        }
    }
}
