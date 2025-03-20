//
//  CDSavedNews+CoreDataProperties.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 20.03.2025.
//
//

import Foundation
import CoreData


extension CDSavedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSavedNews> {
        return NSFetchRequest<CDSavedNews>(entityName: "CDSavedNews")
    }

    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var descriptionLabel: String?
    @NSManaged public var content: String?
    @NSManaged public var category: String?
    @NSManaged public var author: String?

}

extension CDSavedNews : Identifiable {

}
