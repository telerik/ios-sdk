##Send Data to Apple Watch with Core Data and Telerik UI for iOS in Swift

The Apple Watch has been a long rumored device that finally appeared in September, followed by a Watch SDK, called WatchKit, in November. The introduction of the SDK maybe raised more questions than it answered, and like everybody else, we're looking into the future for answers from Apple. One question is: how can I send data, larger than what is allowed for a push notification, from the iPhone to the Watch? Well, there are several ways to do it:

- NSUserDefaults
- Files
- Core Data

There isn’t a single recommended approach by Apple, so all these methods are legit. However, NSUserDefaults is more appropriate for user preferences, rather than real data, and files may not be a good solution for all data scenarios. Therefore, if we have to choose, we will bet on [Core Data](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html), and today I am going to show you how you can send your [Telerik Chart for iOS](http://www.telerik.com/ios-ui) to the Apple Watch in the form of an image and a string stored in Core Data.

![AppleWatch-CoreData](http://blogs.telerik.com/images/default-source/ui-for-ios-team/applewatch-blogpost.png?sfvrsn=2 "AppleWatch-CoreData")

The most common scenario is to have an existing iPhone app project, using Telerik Chart for iOS, which you want to compliment with an Apple Watch app. So, this tutorial assumes that you already have such a project, and it’s called AppleWatchWithTelerikChart. Don’t worry if you didn’t check the Use Core Data checkbox back then when you created your iPhone app. We will assume that Core Data is not enabled initially, and will show you how to enable it in the existing app. Last but not least, this tutorial assumes that you are using Swift as your primary language.

The complete project structure will consist of an iPhone app, a WatchKit app and a framework that directly communicates with Core Data. We will use Xcode 6.2 Beta 4 to do all this. So, let’s get started.

####Creating the WatchKit app

With your iPhone app project opened in Xcode, go to File >> Target >> iOS >> Apple Watch >> WatchKit App and click Next. 

![WatchKit](http://blogs.telerik.com/images/default-source/ui-for-ios-team/watchkit.png?sfvrsn=2 "WatchKit")

Check the Include Notification Scene and Include Glance Scene checkboxes as you may need them at some point during your future development. In this tutorial we will focus on the main WatchKit app. The Product Name field will be filled in automatically for you, so just click Finish. 

![GlanceNotification](http://blogs.telerik.com/images/default-source/ui-for-ios-team/glancenotification.png?sfvrsn=2 "GlanceNotification")

You will be asked whether to activate the AppleWatchWithTelerikChart WatchKit App scheme. Click Activate.
Open the Interface.storyboard from the AppleWatchWithTelerikChart WatchKit App folder and add Image and Label components to the Interface Controller Scene.

Using Ctrl+drag, create IBOutlets and name them chartImageView and titleLabel. 

![AppleWatch-InterfaceStoryboard](http://blogs.telerik.com/images/default-source/ui-for-ios-team/interfacestoryboard.png?sfvrsn=2 "AppleWatch-InterfaceStoryboard")

	@IBOutlet weak var chartImageView: WKInterfaceImage!
	@IBOutlet weak var titleLabel: WKInterfaceLabel!

####Creating the data proxy library

With your iPhone app project opened in Xcode, go to File >> Target >> iOS >> Framework & Library >> Cocoa Touch Framework and click Next.

Name the library WatchCoreDataProxy and select Swift from the Language drop-down. Click Finish.

Right-click the WatchCoreDataProxy folder from the project structure panel and select New File >> iOS >> Core Data >> Data Model.

Name the model WatchModel and click Create. This will create your model file and will open the Model editor for you.

Create a new entity called ChartDataEntity and add two fields to the entity:
- imageBinaryData of type Binary Data
- stringData of type String

![DataModelChart](http://blogs.telerik.com/images/default-source/ui-for-ios-team/datamodelchart.png?sfvrsn=2 "DataModelChart")

Now it’s time to implement the code needed to talk to the SQLite db behind the Core Data. The core logic of this implementation is the boilerplate code that you get in the AppDelegate.swift file when you create a project clicking the Use Core Data checkbox. Basically, this core logic consists of the applicationDocumentsDirectory, managedObjectModel, persistentStoreCoordinator and managedObjectContext properties and the saveContext method.

So, let’s add these to the WatchCoreDataProxy.swift the following way:

Right-click the WatchCoreDataProxy folder >> New File >> iOS >> Source >> Swift File to create a new Swift file and name the file WatchCoreDataProxy.

Add the following code:

	import CoreData
	 
	public class WatchCoreDataProxy: NSObject {
	    public var sharedAppGroup: NSString = ""
	    
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
	        
	        let containerPath = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(self.sharedAppGroup)?.path
	        let sqlitePath = NSString(format: "%@/%@", containerPath!, "WatchModel")
	        let url = NSURL(fileURLWithPath: sqlitePath);
	        
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

Next are the methods you have to implement in the WatchCoreDataProxy class to send data (image and text) from the iPhone app to the SQLite DB through Core Data, and the methods to fetch the saved data and expose it to the WatchKit app:

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
 
####App Groups

Now that we have the iPhone app, the proxy library and the WatchKit app, it’s time to make sure that the iPhone app and the WatchKit app can actually share data. The thing that enables sharing data in whatever form between applications (Files, NSUserDefaults, CoreData) is called App Groups; both applications should be part of the same App Group. To enable the App Groups feature for both apps:

Select the AppleWatchWithTelerikChart project from the project structure panel.

Select the AppleWatchWithTelerikChart app target.

Go to Capabilities >> App Groups and turn that feature ON. You will be asked to select your Development Team/Account.

Check the group.watch.sample group. Of course, you can create your own group name, but for our demo purposes, we will use the default one. 

![AppGroupsiPhone](http://blogs.telerik.com/images/default-source/ui-for-ios-team/appgroupsiphone.png?sfvrsn=2 "AppGroupsiPhone")

Select the AppleWatchWithTelerikChart WatchKit Extension target.
Go to Capabilities >> App Groups and turn that feature ON.
Check the group.watch.sample group. It is important for the name of that group to be the same as the name of the AppleWatchWithTelerikChart’s App Group. 

![AppGroupsWatch](http://blogs.telerik.com/images/default-source/ui-for-ios-team/appgroupswatch.png?sfvrsn=2 "AppGroupsWatch")

####Sending and Getting the Data Using the Proxy Library

With the CoreData proxy, the App Groups enabled and the overall project structure built, let’s send the data from the iPhone through Core Data to the Apple Watch. We will send an image of our chart and a string.
Take a screenshot of the chart. You can do it the following way, assuming that our TKChart instance is called chart:

	UIGraphicsBeginImageContext(chart.bounds.size)
	chart.layer.renderInContext(UIGraphicsGetCurrentContext())
	let image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

Import WatchCoreDataProxy

	import WatchCoreDataProxy

Set the sharedAppGroup property of the Core Data proxy to the name of the App Group:

	WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.sample"

Send the image and the string to the SQLite DB:

	WatchCoreDataProxy.sharedInstance.sendImageToWatch(image)
	WatchCoreDataProxy.sharedInstance.sendStringToWatch(label.text!)

This is it from the iPhone app side. Now, let’s get the data from the SQLite DB and set it to the image and label objects on the Watch.

Import WatchCoreDataProxy.

	import WatchCoreDataProxy

Set the sharedAppGroup of the Core Data proxy to the App Group name:

	WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.sample"

Get the image and the string from the SQLite thought the Core Data proxy:

	let image = WatchCoreDataProxy.sharedInstance.receiveImage()
	let title = WatchCoreDataProxy.sharedInstance.receiveString()

Set the image and string to the chartImageView and titleLabel:

	chartImageView.setImage(image)
	titleLabel.setText(title)

This is one way to send data from iPhone to Apple Watch. We are looking forward to seeing if Apple will introduce another API for this data transfer between devices, but until that time comes, you can use this approach.

Happy coding!