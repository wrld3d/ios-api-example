<a href="https://www.wrld3d.com/">
    <img src="https://cdn2.wrld3d.com/wp-content/uploads/2017/04/WRLD_Blue.png"  align="right" height="80px" />
</a>

# WRLD iOS API Samples
Samples demonstrating how to use the WRLD iOS API to display beautiful, interactive 3D maps on iOS devices.

## Building and running the samples

### Prerequisites
* Latest Xcode (Tested 7.x and 8.x)
* [CocoaPods](https://guides.cocoapods.org/using/getting-started.html)

### Setup
1.  Clone or download snapshot of this repo.
2.  Install dependencies by running `pod install` from the root of the repo.
3.  Obtain a [WRLD API key](https://www.wrld3d.com/developers/apikeys) and place it in the appropriate **Info.plist** file. This is described in the ['Set your WRLD API key'](#set-your-wrld-api-key) step below.
4.  Open, build, and run **api-samples.xcworkspace** in Xcode.

You should see the following two schemes in the project: [HelloWorld](https://github.com/wrld3d/ios-api-example/tree/master/HelloWorld) and [ApiSamples](https://github.com/wrld3d/ios-api-example/tree/master/ApiSamples).

**Note:** Run `pod update` followed by `pod install` to update the pod to the latest version if you have already setup your pod as above.

### CocoaPods
CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like the WRLD iOS API in your projects. If you're already familiar with CocoaPods, [skip ahead](#set-your-wrld-api-key). For more information about CocoaPods, including installation instructions, see the [CocoaPods guide](https://guides.cocoapods.org/).

The [WRLD iOS API CocoaPod](https://cocoapods.org/pods/wrld) can be used by your project by including the 'wrld' pod in your Podfile. This saves having to manually configure and maintain an Xcode project which includes the API.

#### Podfiles
A minimal Podfile looks like this:
```ruby
target 'MyApp' do
  pod 'wrld'
end
```

This Podfile contains the WRLD pod, as well as other dependencies required for the app. Notice that we do not specify a version for the WRLD pod; this means that the app will get the latest WRLD API version when running **pod update**.

### Set your WRLD API key
In order to use the WRLD iOS API, you must sign up for a free developer account at https://www.wrld3d.com/developers. After signing up, you'll be able to create an [API key](https://www.wrld3d.com/developers/apikeys) for your apps. 

After signing up for a developer account and creating an API key, add it to either or both the HelloWorld [plist file](https://github.com/wrld3d/ios-api-example/blob/master/HelloWorld/Info.plist#L47) and the ApiSamples [plist file](https://github.com/wrld3d/ios-api-example/blob/master/ApiSamples/Info.plist#L47).

If you are creating a new app, or integrating WRLD 3D Maps into an existing app, the API key should be present in the main bundle info dictionary for the key "WrldApiKey" at the time the [WRLDMapView](https://github.com/wrld3d/ios-api/blob/master/src/private/WRLDMapView.mm) is created.

### HelloWorld
The [HelloWorld](https://github.com/wrld3d/ios-api-example/tree/master/HelloWorld) example is a basic app displaying a WRLD map. It demonstates how to integrate WRLD maps into your existing iOS application.

#### Build and run
To build it, select the "HelloWorld" scheme, "Product->Scheme->HelloWorld" and run, "Product->Run". If you have a debuggable iOS device attached, or if you are running a simulator, you can debug or run the app with the standard Xcode tools.

For a step-by-step instructions which shows how to create a basic app from scratch, see [our walkthrough documentation](https://docs.wrld3d.com/ios/latest/docs/api/Walkthrough/).

### ApiSamples
The [ApiSamples](https://github.com/wrld3d/ios-api-example/tree/master/ApiSamples) app contains a collection of examples, each illustrating an individual API feature.

#### Build and run
To build the examples, select the "ApiSamples" scheme, "Product->Scheme->ApiSamples" and run, "Product->Run".

## Further information
See our [API docs](https://docs.wrld3d.com/ios/latest/docs/api/) for detailed class documentation and other information.

Questions, comments, or problems? All feedback is welcome -- just [create an issue](https://github.com/wrld3d/ios-api-example/issues).

## WRLD iOS SDK
These samples make use of the WRLDS iOS SDK, available via [CocoaPods](https://cocoapods.org/pods/wrld). 

The source for the SDK is available at https://github.com/wrld3d/ios-api

## License
These samples are released under the Simplified BSD License. See the [LICENSE.md](https://github.com/wrld3d/ios-api-example/blob/master/LICENSE.md) file for details.
