##Send Data to Apple Watch with Core Data and Telerik UI for iOS in Swift

The Apple Watch has been a long rumored device that finally appeared in September, followed by a Watch SDK, called WatchKit, in November. The introduction of the SDK maybe raised more questions than it answered, and like everybody else, we're looking into the future for answers from Apple. One question is: how can I send data, larger than what is allowed for a push notification, from the iPhone to the Watch? Well, there are several ways to do it:

- NSUserDefaults
- Files
- Core Data

There isn’t a single recommended approach by Apple, so all these methods are legit. However, NSUserDefaults is more appropriate for user preferences, rather than real data, and files may not be a good solution for all data scenarios. Therefore, if we have to choose, we will bet on [Core Data](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html), and today I am going to show you how you can send your [Telerik Chart for iOS](http://www.telerik.com/ios-ui) to the Apple Watch in the form of an image and a string stored in Core Data.

![AppleWatch-CoreData](http://blogs.telerik.com/images/default-source/ui-for-ios-team/applewatch-blogpost.png?sfvrsn=2 "AppleWatch-CoreData")

The most common scenario is to have an existing iPhone app project, using Telerik Chart for iOS, which you want to compliment with an Apple Watch app. So, this tutorial assumes that you already have such a project, and it’s called AppleWatchWithTelerikChart. Don’t worry if you didn’t check the Use Core Data checkbox back then when you created your iPhone app. We will assume that Core Data is not enabled initially, and will show you how to enable it in the existing app. Last but not least, this tutorial assumes that you are using Swift as your primary language.

The complete project structure consists of an iPhone app, a WatchKit app and a framework that directly communicates with Core Data. We use Xcode 6.2 Beta 4 to do all this.

For more information on how the project is built, please refer to the following blog article: [Send Data to Apple Watch with Core Data and Telerik UI for iOS in Swift](http://blogs.telerik.com/blogs/15-02-03/send-data-to-apple-watch-with-core-data-and-telerik-ui-for-ios-in-swift)

Note that in order to build the project, you need [Telerik UI for iOS](http://www.telerik.com/ios-ui). 


NOTE: This project is updated to work with Xcode 6.3 Beta (w/ Swift 1.2)
