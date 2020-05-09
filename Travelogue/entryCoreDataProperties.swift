//
//  entryCoreDataProperties.swift
//  Travelogue
//
//  Created by Jasmine Tan on 5/7/20.
//  Copyright © 2020 Jasmine Tan. All rights reserved.
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var entryName: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var picture: NSData?
    @NSManaged public var text: String?
    @NSManaged public var trip: Trip?

}
