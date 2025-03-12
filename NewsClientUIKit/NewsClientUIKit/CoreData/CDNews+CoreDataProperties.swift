//
//  CDNews+CoreDataProperties.swift
//  NewsClientUIKit
//
//  Created by Ruslan Liulka on 12.03.2025.
//
//

import Foundation
import CoreData


extension CDNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNews> {
        return NSFetchRequest<CDNews>(entityName: "CDNews")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionLable: String?
    @NSManaged public var image: Data?
    @NSManaged public var content: String?
    @NSManaged public var publishTime: String?
    @NSManaged public var name: String?

}

extension CDNews : Identifiable {

}
