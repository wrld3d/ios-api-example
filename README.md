eeGeo 3D Maps iOS API Example
=============================

Example client for the Objective-C iOS bindings for the eeGeo SDK, a C++11 OpenGL-based library for beautiful and customisable 3D maps.

* This repo contains a project that exercises the eeGeo iOS API.
* The API is distributed via [CocoaPods](https://cocoapods.org/pods/eegeo). Run 'pod install' to generate an XCode workspace.
* Open the generated eeGeoApiExample.xcworkspace to build and run the app.
* You must sign up for an [eeGeo 3D Maps API key](https://www.eegeo.com/developers/apikeys/) to use the eeGeo 3D Map. Add the key to the app [plist file](https://github.com/eegeo/ios-api-example/blob/master/ExampleApp/eeGeoApiExample-Info.plist#L5-L8).
	* You may also optionally sign up for a [Google Maps API key](https://developers.google.com/maps/documentation/ios/start#step_5_get_an_ios_api_key) to ensure the Google Map example loads. 
* The example project shows the same scene in eeGeo 3D Maps, MapKit and Google Maps. 
* The client code demonstrates that the eeGeo 3D maps iOS API is similar to MapKit; in some cases, it can be used as a drop-in replacement!
* The API is continuously deployed; run 'pod update' to get the most up to date version.
* Pull requests accepted.
