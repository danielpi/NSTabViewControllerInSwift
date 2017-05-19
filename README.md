# NSTabViewController in Swift
A simple example of using a NSTabViewController in a Mac app (Sierra, Xcode 8.3, Using storyboards).

## Steps I followed to create
- Started with a new Xcode project in Xcode 8.3 on Sierra.
- In the main storyboard delete the ViewController that had been setup as the main content for the window.
- Drag a tab view controller out and place it under the window object.
- Control-Drag from the WindowController (not the window) to the TabViewController to create a relationship segue for the window content.
![Image of the NSTabViewController being connected to the WindowController in IB](https://danielpi.github.com/NSTabViewControllerInSwift/images/Connecting window content.png)
- Add something to the two existing view controllers for the tab view items (I just added and centred two labels).
- Change the tab labels. This can be done using the Label field in the Attributes Inspector. Note, you can double click on the word in the Tab and it will allow you to edit it. However this will not change the Label attribute. Not sure why you would want it to work that way???

Build and run. At this point the application will display a window with a functioning TabView in it. There will be two tabs and the user can select which one is up front.

## Making it useful
At this stage we have reached "Peak IB Demo" stage. "Wow, it is so easy to create NSTabViewControllers in Interface Builder!". However if we were to stop here the entire thing would be pretty much useless.

- Create controllers for each of the UI elements so that you have somewhere to put your code. This is probably obvious to everyone else but I always seem to get tripped up by it. All the IB demos that show something useful without any code led me to think that you shouldn't need to subclass much. However almost any project quickly gets to a point where these custom controllers are needed.
- To do this I deleted the ViewController file. Then for each of the WindowController, TabViewController, ViewControllerOne and ViewControllerTwo I created a new file (Cocoa Class) and subclassed their relevant types (NSWindowController, NSTabViewController, NSViewController).
- In interface builder select each controller object (one at a time) and go to the Identity Inspector. In the Custom Class section you can tell it to use your new classes.

The app now functions the same as it did before however we now have a place for any code that we need to write. Ultimately you may not need all of these controllers subclassed.

### Passing data between the controllers

### Headless tabs

### Switching tabs programmatically