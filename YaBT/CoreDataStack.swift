import Foundation
import CoreData

/* This is what I got when I "translated" the Objective-C class in
CoreDataStack.m to Swift.  It compiles but has not been tested. */

public class CoreDataStack {
    
    public init() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "contextDidSave:",
            name: NSManagedObjectContextDidSaveNotification,
            object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory,
            inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    public var managedObjectModel: NSManagedObjectModel = {
        var modelPath = NSBundle.mainBundle().pathForResource("YaBT", ofType: "momd")
        var modelURL = NSURL.fileURLWithPath(modelPath!)
        var model = NSManagedObjectModel(contentsOfURL: modelURL!)
 
        return model
    }()
    
    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var storeUrl = self.applicationDocumentsDirectory.URLByAppendingPathComponent("YaBT.sqlite")

        var fileExists: Bool = NSFileManager.defaultManager().fileExistsAtPath(storeUrl.path!)
        var error: NSErrorPointer = nil
        if fileExists == false {
            var fakeDataPath: NSString = NSBundle.mainBundle().pathForResource(
                "FakeData",
                ofType: "sqlite")!
            var fakeDataUrl: NSURL = NSURL.fileURLWithPath(fakeDataPath)!
            var ok: Bool = NSFileManager.defaultManager().copyItemAtURL(
                fakeDataUrl,
                toURL: storeUrl,
                error: error)
            if (ok == false) {
                NSLog(error.debugDescription)
                abort()
            }
        }
        
        var options = [
            NSInferMappingModelAutomaticallyOption: true,
            NSMigratePersistentStoresAutomaticallyOption: true]
        var psc: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(
            managedObjectModel: self.managedObjectModel)
        var ps = psc!.addPersistentStoreWithType(
            NSSQLiteStoreType,
            configuration:nil,
            URL: storeUrl,
            options: options,
            error: error)
        
        if (ps == nil) {
            NSLog(error.debugDescription)
            abort()
        }
        
        return psc
    }()
    
    public lazy var rootContext: NSManagedObjectContext? = {
        var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    public lazy var mainContext: NSManagedObjectContext? = {
        var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.parentContext = self.rootContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()

    func newWorkerContextNamed(name: NSString!) -> NSManagedObjectContext {
        var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.parentContext = self.rootContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }
    
    @objc func contextDidSave(notification: NSNotification) {
        var savedContext: AnyObject = notification.object!
        var parentContext: NSManagedObjectContext? = savedContext.parentContext
        if parentContext != nil {
            self.saveContext(parentContext!)
        }
    }
    
    public func saveContext(context: NSManagedObjectContext) {
        context.performBlock() {
            var error: NSError? = nil
            if !(context.obtainPermanentIDsForObjects(context.insertedObjects.allObjects, error: &error)) {
                NSLog("Error permanentizing IDs for \(context.insertedObjects.allObjects): \(error)")
            }
            
            if !(context.save(&error)) {
                NSLog("Unresolved core data error: \(error)")
                abort()
            }
        }
    }
    
    public func saveRootContext() {
       self.saveContext(self.rootContext!)
    }
    
    public func saveMainContext() {
        self.saveContext(self.mainContext!)
    }
    
}



