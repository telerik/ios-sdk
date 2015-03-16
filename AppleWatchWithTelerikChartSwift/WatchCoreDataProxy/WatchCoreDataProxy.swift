//
//  WatchCoreDataProxy.swift
//  AppleWatchWithTelerikChart
//
//  Created by Nikolay Diyanov on 1/28/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation
import CoreData

public class WatchCoreDataProxy: NSObject {
    public var sharedAppGroup: NSString = ""
    
    public class var sharedInstance : WatchCoreDataProxy {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : WatchCoreDataProxy? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = WatchCoreDataProxy()
        }
        
        return Static.instance!
    }
    
    public func sendImageToWatch(image:UIImage){
        let imageData: NSData  = UIImagePNGRepresentation(image);
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("ChartDataEntity", inManagedObjectContext: self.managedObjectContext!)
        
        
        var request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results = self.managedObjectContext?.executeFetchRequest(request, error: &error)
        if(results?.count==0){
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("ChartDataEntity", inManagedObjectContext: context!) as NSManagedObject
            
            newManagedObject.setValue(imageData, forKey: "imageBinaryData")
            
        }else{
            let existingObject: NSManagedObject = results![0] as NSManagedObject
            existingObject.setValue(imageData, forKey: "imageBinaryData")
        }
        
        if !(context?.save(&error) != nil) {
            println("Unresolved error \(error), \(error?.userInfo)")
            abort()
        }
    }
    
    public func receiveImage()-> UIImage? {
        
        var request = NSFetchRequest()
        var entity = NSEntityDescription.entityForName("ChartDataEntity", inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        
        var error: NSError? = nil
        let results = self.managedObjectContext?.executeFetchRequest(request, error: &error)
        
        var image: UIImage?
        if results != nil && results?.count > 0 {
            let managedObject: NSManagedObject = results![0] as NSManagedObject
            let myData: NSData? = managedObject.valueForKey("imageBinaryData") as? NSData
            image = UIImage(data: myData!)
        }
        
        return image
    }
    public func sendStringToWatch(stringData:NSString){
        
        let context = self.managedObjectContext
        let entity = NSEntityDescription.entityForName("ChartDataEntity", inManagedObjectContext: self.managedObjectContext!)
        
        
        var request = NSFetchRequest()
        request.entity = entity
        var error: NSError? = nil
        let results = self.managedObjectContext?.executeFetchRequest(request, error: &error)
        if(results?.count==0){
            let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName("ChartDataEntity", inManagedObjectContext: context!) as NSManagedObject
            
            newManagedObject.setValue(stringData, forKey: "stringData")
            
        }else{
            let existingObject: NSManagedObject = results![0] as NSManagedObject
            existingObject.setValue(stringData, forKey: "stringData")
        }
        
        if !(context?.save(&error) != nil) {
            println("Unresolved error \(error), \(error?.userInfo)")
            abort()
        }
    }
    
    public func receiveString()-> NSString? {
        
        var request = NSFetchRequest()
        var entity = NSEntityDescription.entityForName("ChartDataEntity", inManagedObjectContext: self.managedObjectContext!)
        request.entity = entity
        
        var error: NSError? = nil
        let results = self.managedObjectContext?.executeFetchRequest(request, error: &error)
        
        var stringData: NSString?
        if results != nil && results?.count > 0 {
            let managedObject: NSManagedObject = results![0] as NSManagedObject
            stringData = managedObject.valueForKey("stringData") as? NSString
        }
        
        return stringData
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let proxyBundle = NSBundle(identifier: "com.telerik.WatchCoreDataProxy")
        let modelURL = proxyBundle?.URLForResource("WatchModel", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL!)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        let containerPath = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(self.sharedAppGroup as String)?.path
        let sqlitePath = NSString(format: "%@/%@", containerPath!, "WatchModel")
        let url = NSURL(fileURLWithPath: sqlitePath as String);
        
        let  model = self.managedObjectModel;
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: model)
        var error: NSError? = nil
        
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
}
