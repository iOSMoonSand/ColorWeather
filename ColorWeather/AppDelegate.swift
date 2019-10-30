//
//  AppDelegate.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/17/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import CoreData
import os
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // TODO: remove test code
//        let weatherDataRequestService = WeatherDataRequestService()
//
//        weatherDataRequestService.requestWeatherData(from: "san+francisco,us",
//                                             completion: { weatherDataModel, error in
//                                                guard error == nil else {
//                                                    print("***** ERROR *****")
//                                                    return
//                                                }
//                                                print("***** weatherDataModel: \(weatherDataModel)")
//        })
        
        
        
        //tag alexis//////////
        resetStore()
        
        insertCityData()
        
        return true
    }
    
    func insertCityData() {
        
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        let count = try! persistentContainer.viewContext.count(for: fetchRequest)
        
        if count > 0 {
            return
        }
        
//        DispatchQueue.global(qos: .background).async {
            
            guard
                let path = Bundle.main.path(forResource: "cities", ofType: "json"),
                let data = NSData(contentsOfFile: path) as Data?
                else {
                    os_log(OSLogConstants.CoreData.errorFailedToLoadJSON, log: .coreData, type: .error)
                    return
            }
            
            do { //tag alexis do i want to force cast?
                let dataArray = try JSONSerialization.jsonObject(with: data) as! [JSONDictionary]
                
                dataArray.forEach { [weak self] cityJSONObject in
                    
                    guard let self = self else {
                        os_log(OSLogConstants.Shared.errorFailedToAccessSelf, log: .general, type: .error)
                        return
                    }
                    
                    guard let cityEntity = NSEntityDescription.entity(forEntityName: "City",
                                                                      in: self.persistentContainer.viewContext) else {
                                                                         os_log(OSLogConstants.CoreData.errorFailedToReturnEntity,
                                                                               log: .coreData,
                                                                               type: .error)
                                                                        return
                    }
                    
                    let cityManagedObject = City(entity: cityEntity, insertInto: self.persistentContainer.viewContext)
                    
                    // tag alexis test code
                    if let name = cityJSONObject["name"] as? String {
                        cityManagedObject.name = name
                    } else {
                        cityManagedObject.name = nil
                    }
                    
                    if let code = cityJSONObject["country"] as? String {
                        cityManagedObject.countryCode = code
                    } else {
                        cityManagedObject.countryCode = nil
                    }
                    
                    if let id = cityJSONObject["id"] as? NSNumber {
                        cityManagedObject.id = id.int32Value
                    } else {
                        cityManagedObject.id = 0
                    }
                }
                
                self.saveContext()
                
            } catch {
                os_log(OSLogConstants.Shared.errorFailedSerialization, log: .coreData, type: .error, error.localizedDescription)
            }
            
            
//        }
    }
    
    func saveContext() {
        
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                // The do-catch statement includes a local variable `error` to handle all thrown error types.
                os_log(OSLogConstants.CoreData.errorFailedToSaveContext, log: .coreData, type: .error, error.localizedDescription)
            }
        }
    }
    
    //tag alexis test code//////////
    func resetStore() {
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    
    /// The persistent container for the application. This implementation creates
    /// and returns a container, having loaded the store for the application to it.
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container: NSPersistentContainer? = NSPersistentContainer(name: "ColorWeather")
        container?.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // TODO: Alert user if nil.
                os_log(OSLogConstants.CoreData.errorFailedStoreLoading, log: .coreData, type: .error, error.localizedDescription)
            }
        })
        
        guard var persistentContainer = container else {
            // TODO: Alert user if nil.
            os_log(OSLogConstants.CoreData.errorFailedStoreCreation, log: .coreData, type: .error)
            return NSPersistentContainer()
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        return persistentContainer
    }()

}

