# ViewCoordinator

[![CI Status](http://img.shields.io/travis/LamourBt/ViewCoordinator.svg?style=flat)](https://travis-ci.org/LamourBt/ViewCoordinator)
[![Version](https://img.shields.io/cocoapods/v/ViewCoordinator.svg?style=flat)](http://cocoapods.org/pods/ViewCoordinator)
[![License](https://img.shields.io/cocoapods/l/ViewCoordinator.svg?style=flat)](http://cocoapods.org/pods/ViewCoordinator)
[![Platform](https://img.shields.io/cocoapods/p/ViewCoordinator.svg?style=flat)](http://cocoapods.org/pods/ViewCoordinator)


We're hoping to ease the way that we present multiples UIViews onto any Controllers.
Instead of hiding views that you'd need to present at a certain time, you would just need to
drop all your views into a container, then use the ViewCoordinator mechanism to bring them back into screen.

## OverView

No need to manually adding views to the parent's view, No need need to create repeated code to present or dismiss
your views. Just wrap your views with a ViewWrapper and drop that single or array of ViewWrappers into the ViewCoordinator's container.

```Swift
private func singleViewManipulation() {
	let _view = UIView(frame: view.frame) // create your view
    _view.backgroundColor = .red
    let firstViewWrapper = ViewWrapper(view: _view, uid: "SingleViewTag") // wrap your view
	viewCoordinator?.addMultipleViewsToStack([firstViewWrapper]) // drop into our container
}

viewCoordinator?.presentTopView() // it would present that single view onto your controller

viewCoordinator?.dismissTopView() // it would dismiss that single view from your controller

```
## Run Example Project

To run the example project to explore and see more examples, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation (Currently Facing an issue with the pod, so I'll add a swift manager package to it)

ViewCoordinator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ViewCoordinator'
```

## Questions, Issues or Suggestions

Feel free to open any issues.

## Author

lamour

## License

ViewCoordinator is available under the MIT license. See the LICENSE file for more info.
