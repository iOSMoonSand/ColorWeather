//
//  City+CoreDataProperties.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/29/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var countryCode: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
