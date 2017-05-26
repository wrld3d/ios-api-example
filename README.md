<a href="https://www.wrld3d.com/">
    <img src="https://cdn2.wrld3d.com/wp-content/uploads/2017/04/WRLD_Blue.png"  align="right" height="80px" />
</a>

# WRLD iOS API Samples
Samples demonstrating how to use the WRLD iOS API to display beautiful, interactive 3D maps on iOS devices.

## Getting started

### Prerequisites
* Xcode (version 7.3 or later)
* [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation)
* A [WRLD API key](https://www.wrld3d.com/developers/apikeys)

### Installing
1. In root of repo, run ```pod install``` to setup dependencies using [CocoaPods](https://cocoapods.org).
2. ```open api-samples.xcworkspace``` to open the generated Xcode workspace.
3. Place your [WRLD API key](https://www.wrld3d.com/developers/apikeys) in the **Info.plist** file for each example app. See ['Set your WRLD API key'](#set-your-wrld-api-key) below for details.

You will see two schemes in the project:
* HelloWorld - this is a minimal app, demonstrating how to drop a WRLDMapView into your app using Interface Builder.
* ApiSamples - this app contains a collection of samples, each illustrating an individual API feature.

Select the active scheme for the app you want to build in Xcode, then build and run the app.

### Set your WRLD API key
In order to run these samples, you need to sign up for a free developer account at https://www.wrld3d.com/developers. Then create an [API key](https://www.wrld3d.com/developers/apikeys) to use in your apps. 

These example apps read the API key from their Info.plist file. Set the value of the 'WrldApiKey' entry with the API key that you have just created.

See:
* https://github.com/wrld3d/ios-api-example/blob/master/HelloWorld/Info.plist#L47
* https://github.com/wrld3d/ios-api-example/blob/master/ApiSamples/Info.plist#L47

If you are creating a new app, or integrating WRLD 3D Maps into an existing app, the API key should be present in the main bundle info dictionary for the key "WrldApiKey" at the time the [WRLDMapView](https://github.com/wrld3d/ios-api/blob/master/src/private/WRLDMapView.mm) is created.

## Further information
For more detailed information, see the [API documentation](https://docs.wrld3d.com/ios/latest/docs/api/) and [API examples](https://docs.wrld3d.com/ios/latest/docs/examples/).

We also have [step-by-step instructions](https://docs.wrld3d.com/ios/latest/docs/api/Walkthrough/) on how to integrate a WRLD map view into your app.

Questions, comments, or problems? All feedback is welcome - just [create an issue](https://github.com/wrld3d/ios-api-example/issues).

## WRLD iOS SDK
These samples use the WRLD iOS SDK, available via [CocoaPods](https://cocoapods.org/pods/WRLD). 

The source for the SDK is available at https://github.com/wrld3d/ios-api

## License
These samples are released under the Simplified BSD License. See the [LICENSE.md](https://github.com/wrld3d/ios-api-example/blob/master/LICENSE.md) file for details.
