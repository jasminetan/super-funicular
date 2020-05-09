//
//  tripCoreDataClass.swift
//  Travelogue
//
//  Created by Jasmine Tan on 5/7/20.
//  Copyright © 2020 Jasmine Tan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Trip)
public class Trip: NSManagedObject {
    var entries: [Entry]?{
        return self.rawEntries?.array as? [Entry]
    }
    
    convenience init?(title: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: context)
        self.tripName = title
    }
    

}

