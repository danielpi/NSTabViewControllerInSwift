# NSTabViewController in Swift
A simple example of using a NSTabViewController in a Mac app (Sierra, Xcode 8.3, Using storyboards).

## Steps I followed to create
- Started with a new Xcode project in Xcode 8.3 on Sierra.
- In the main storyboard delete the ViewController that had been setup as the main content for the window.
- Drag a tab view controller out and place it under the window object.
- Control-Drag from the WindowController (not the window) to the TabViewController to create a relationship segue for the window content.
![Image of the NSTabViewController being connected to the WindowController in IB](https://raw.githubusercontent.com/danielpi/NSTabViewControllerInSwift/master/images/Connecting window content.png)

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
**WindowController accessing the TabViewController.** There are several different ways to do this. One option is shown below
		
        override func windowDidLoad() {
      
        	super.windowDidLoad()
        	
        	guard let tvc = contentViewController as? TabViewController else {
                fatalError()
            }
            dump(tvc)
        }

Could also access the WindowController.window?.contentViewController if you like. You could also make an explicit connection via @IBOutlets.

**TabViewController accessing Tab View Controllers.** Lots of ways to do this. Different trade offs between the methods and the most suitable will depend on what sort of interaction you need. TODO: Flesh this out with some reasonable examples.

**WindowController accessing ViewControllers.** 
One possible reason for needing the WindowController to be able to access the ViewControllers in the 

    let selectedIndex = tabViewController.selectedTabViewItemIndex
    let selectedTabViewItem = tabViewController.tabViewItems[selectedIndex]
    if let selectedViewController = selectedTabViewItem.viewController {
        switch selectedViewController {
        case is ViewControllerOne:
            print("Selected ViewController is of type ViewControllerOne")
            dump(selectedViewController)
        case is ViewControllerTwo:
            print("Selected ViewController is of type ViewControllerTwo")
            dump(selectedViewController)
        default:
            print("Mystery ViewController")
        }
    }

### Headless tabs
This can be useful when you want to be able to have multiple different screens be switched for a window without the user specifically selecting which tab is displayed. Something like going from one mode to another.

Best explanation for how to do this on the web that I could find was the top answer to this question. http://stackoverflow.com/questions/37219946/hide-tab-bar-in-nstabviewcontroller-in-storyboard

Basically two steps
- First, select the tab view controller and set its Style in the Attributes Inspector to “Unspecified”
- Next, select the tab view under the tab view controller and set its Style to “Tabless”

Now main window just displays the contents of the first tab from the tabview. No other chrome is visible to currently selected view controller has control over the complete canvas. But which tab is visible? and how to you select another?

### Switching tabs programmatically
**Bug:** First up we need to fix a bug that is present in macOS 10.12. The tabView delegate should be the TabViewController that was created for us by Interface Builder. Apparently it was in macOS 10.11 and hopefully it will be again in macOS 10.13 but for now we need to set this manually. 

    class TabViewController: NSTabViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do view setup here.
        
            tabView.delegate = self
        }
    }

This should fix up a bunch of things relating to the NSTabViewController receiving messages from the NSTabView when the tab selection changes and the like. More details below
- http://stackoverflow.com/questions/27488481/nstabviewcontroller-ignoring-transitions-and-title-propagation-settings
- http://www.openradar.me/22348095

I'm going to use the space bar as a toggle between the two viewControllers. So the WindowController will listen for the key down signal from the space bar. It will then ask the TabViewController to switch the selectedTabViewController.

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49: // Space bar
            print("Spacebar")
            if let vc = contentViewController as? TabViewController {
                if vc.selectedTabViewItemIndex == 1 {
                    vc.tabView.selectTabViewItem(at: 0)
                } else {
                    vc.tabView.selectTabViewItem(at: 1)
                }
            }
        default:
            break
        }
    }

