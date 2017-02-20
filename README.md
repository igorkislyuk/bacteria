# BACTERIA
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Bacteria.svg)](https://img.shields.io/cocoapods/v/Bacteria.svg)
[![Platform](https://img.shields.io/cocoapods/p/Bacteria.svg?style=flat)](http://cocoadocs.org/docsets/Bacteria)

**Framework is for basic modal viewcontroller transitions with human syntax. Special developed for ObjC users**

<img src="https://github.com/igorkislyuk/bacteria/blob/develop/gifs/example-1.gif" width="267px"/>

This done with following example
```objective-c
    yourViewController.
    presentTransition(BCTTransitionFlip).
    fromDirection(BCTDirectionTop).
    dismissTransition(BCTTransitionPopRadial).
    popTo(self.testButton).
    withDuration(0.45f);
```

## Feature list

* human syntax for transitions for ObjC
* support segues, not only for modal code presentation
* support different transition types (flat, flip, pop, safari)
* support all side modal controller presentation (note: flat extended)
* support scaling for present and dismiss controller views (note: just for flat)
* support auto-reverse functionality(means you can specify only one type for presental/dismissal and the other will be inferred automatically)

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Bacteria in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate Bacteria into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'Bacteria'
end
```

Then, run the following command:

```bash
$ pod install
```

## How to

Any instruction should be applied to presented controller. You can get it two ways:

1. Create it manually and present
```objective-c
	//get controller
	BCTPresentedViewController *presented = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([BCTPresentedViewController class])];
  
  	//bacteria configuration  
    presented.
    presentTransition(BCTTransitionSafari).
    dismissTransition(BCTTransitionFlatParallel).
    toDirection(BCTDirectionTop).
    withDuration(1.45f);
    
    [self presentViewController:presented animated:YES completion:nil];
```
2. Using segue tracker
```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //get presented controller
    BCTPresentedViewController *presented = segue.destinationViewController;
    
    //bacteria configuration
    presented.
    presentTransition(BCTTransitionFlip).
    fromDirection(BCTDirectionTop).
    dismissTransition(BCTTransitionPopRadial).
    popTo(self.testButton).
    withDuration(0.45f);
}
```

## Functionality overview

   There is only one required method to call. It's `withDuration`, because of assigning factory as transition delegate under cover. To help figure out, for which controller you will apply your settings, library use several basic keywords, like: **present** is used for controller that will be shown, **dismiss** is used for controller which that be hidden, **from** is used for controller settings that will be shown, **to** is used for controller settings that will be hidden

* `withDuration(XXX)` - use this to specify duration for transition. XXX - float value in seconds. Applied both for present and dismiss transition

* `presentTransition(XXX)` - use this to specify transition type for presented controller. XXX is one of BCTTransitionType values.
* `dismissTransition(XXX)` - use this to specify transition for controller, when it will be dismissing. XXX is one of BCTTransitionType values.

* `fromDirection(XXX)` - use this to specify transition direction for presented controller.
* `toDirection(XXX)` - use this to specify transition direction, when it will be dismissing.
..* Both for 4 & 5: It works only with BCTTransitionFlatParallel, BCTTransitionFlatCover, BCTTransitionFlip (restricted to first 4 types). XXX is one of BCTDirectionType.

* `popFrom(XXX)` & `popTo(XXX)` - use this to pass view which will be anchor for pop animation. (NOTE: ONLY pop transitions)

* `fromScale(XXX, YYY)` & `toScale(XXX, YYY)` - use this to determine initial or final scale for controller. XXX & YYY measure in units. Range from 0 to 1. (NOTE: ONLY flat transitions)

* `fromPoint(XXX)` & `toPoint(XXX)` - use this to specify direct point from controller starts presentation / dismissal. Possibly unused, and should be discussed for removal in future versions. XXX is point.

#### Enum types

Bacteria declares several enum types for configuration.

* `BCTTransitionType` - main enum which declares different transition types. There are:
  * `BCTTransitionFlatParallel` - default one. If you need move your controllers simultaneously, use it.
  * `BCTTransitionFlatCover` - similar to previous, but original controller 'stands still'.
  * `BCTTransitionFlip` - basic flip transition like default one, extended for all 4 sides.
  * `BCTTransitionSafari` - transition's similar to safari-tab with no-customisation. 
  * `BCTTransitionPopRadial` - pop, when controller appears/disappears from dot in center of view.
  * `BCTTransitionPopLinear` - similar to previous, but uses rect with rounded corners instead of center dot.
* `BCTDirectionType` - enum for determine direction for transitions.(NOTE: ONLY for Flat, FlatCover; for Flip transitions you can use only first 4 sides. Others will be converted to first 4)
  * `BCTDirectionTop` - top sied.
  * `BCTDirectionLeft` - left side.
  * `BCTDirectionBottom` - bottom side.
  * `BCTDirectionRight` - right side.
  * `BCTDirectionTopLeft` - top-left corner.
  * `BCTDirectionBottomLeft` - bottom-left corner.
  * `BCTDirectionBottomRight` - bottom-right corner.
  * `BCTDirectionTopRight` - top-right corner.

## Examples

 * Do this one:

```objective-c
    //bacteria configuration
    presented.
    presentTransition(BCTTransitionFlatCover).
    fromDirection(BCTDirectionBottomLeft).
    fromScale(0.5, 0.5).
    dismissTransition(BCTTransitionFlip).
    toDirection(BCTDirectionBottom).
    withDuration(0.45f);
```
   to receive:

   <img src="https://github.com/igorkislyuk/bacteria/blob/develop/gifs/example-2.gif" width="267px"/>
   
 * Do this one:

```objective-c
    //bacteria configuration
    presented.
    presentTransition(BCTTransitionSafari).
    withDuration(0.45f);
```
   to receive:

   <img src="https://github.com/igorkislyuk/bacteria/blob/develop/gifs/example-3.gif" width="267px"/>
   
  * Do this one:

```objective-c
    //bacteria configuration
    presented.
    presentTransition(BCTTransitionSafari).
    withDuration(0.45f);
```
   to receive:

   <img src="https://github.com/igorkislyuk/bacteria/blob/develop/gifs/example-4.gif" width="267px"/>

## TODO Section

#### Version 0.6
- [ ] Add functionality to retain view within container view. Tip: I should use snapshot, not `addSubview:`
- [ ] Add separate duration for present / dismiss
- [ ] Add transitions for viewControllers in navigation stack
- [ ] Add Swift cover file for convenient syntax. Initially it is designated for ObjC users

#### Version 0.7
- [ ] Add interactivity. Users should easily embed transitions in gestures
- [ ] Add support for pop initial point depending on user finger location
- [ ] Add spring values for all kind of transitions

#### Version 0.8
- [ ] Add support for background color of container for transitions
- [ ] Add blur for background container for transitions
- [ ] Add transitions for collections

#### Version 0.9
- [ ] Review whole library for refactor process

## Historical notes

Bacteria initially stands for **B**eautiful **A**nimation **C**ontroller **T**ransition. After some time it was renamed to Bacteria, for short and convenience. In other meaning, it can stands for **Ba**sic **C**ontroller **T**ransitions.

## Contributors

- [Igor Kislyuk](https://github.com/igorkislyuk)

## License

MIT License. See LICENSE file for details.