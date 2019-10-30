//
//  OSLogConstants.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 10/21/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

struct OSLogConstants {

    struct Shared {
        static let errorFailedSerialization: StaticString = "❌ There was an error when trying to serialize the retrieved JSON data: %{public}@"
        static let errorFailedToAccessSelf: StaticString = "❌ There was an error trying to access self in a closure."
    }

    struct WebService {

        static let errorInvalidURL: StaticString = "❌ Invalid URL."
        static let errorNilData: StaticString = "❌ Data object is nil."
        static let errorNoInternet: StaticString = "❌ Not connected to Internet."
        static let errorFailedDataModeling: StaticString = "❌ There was an error creating a model object with the data received from your request."
        static let errorFailedRequest: StaticString = "❌ HTTP request operation failed with status code: %d."
        static let errorUnknown: StaticString = "❌ An unkown error occured: %{public}@"
    }

    struct CoreData {
        static let errorFailedStoreCreation: StaticString = "❌ Failed to load Core Data stack when creating the persistent store.\n\nTypical reasons for an error here include: 1) The parent directory does not exist, cannot be created, or disallows writing. 2) The persistent store is not accessible, due to permissions or data protection when the device is locked. 4) The device is out of space. 5) The store could not be migrated to the current model version."
        static let errorFailedStoreLoading: StaticString = "❌ There was an error loading the persistent stores: %{public}@"
        static let errorFailedToLoadJSON: StaticString = "❌ There was an error loading the local JSON file."
        static let errorFailedToReturnEntity: StaticString = "❌ There was an error returning the specified entity in the specified context'store. See NSEntityDescription.entity(forEntityName:in:). "
        static let errorFailedToSaveContext: StaticString = "❌ There was an error saving the Core Data context: %{public}@"
    }
}
