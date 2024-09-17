//
//  FavoriteNews+CoreDataProperties.swift
//  NewsApplication
//
//  Created by Ayush on 17/09/24.
//
//

import Foundation
import CoreData


extension FavoriteNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNews> {
        return NSFetchRequest<FavoriteNews>(entityName: "FavoriteNews")
    }

    @NSManaged public var id: String?
    @NSManaged public var url: String?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?

}

extension FavoriteNews : Identifiable {

}
