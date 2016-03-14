![eeGeo](http://cdn2.eegeo.com/wp-content/uploads/2015/06/wide_eegeo_logo_hero.jpg)

- [Getting started](#getting-started)
    - [CocoaPods](#cocoapods)
    - [eeGeo API Key](#eegeo-api-key)
- [API Overview](#api-overview)
    - [EGMapView](#egmapview)
    - [EGMapDelegate](#egmapdelegate)
    - [EGMapAPI](#egmapapi)
        - [Annotations](#annotations)
        - [Themes](#themes)
- [Support](#support)
- [Contributing](#contributing)
- [License](#license)

# eeGeo 3D Maps iOS API

This example app showcases the [eeGeo iOS API](https://github.com/eegeo/ios-api), a C++11 OpenGL-based library for [beautiful and customisable 3D maps](http://www.eegeo.com). It is a minimal app that demonstrates the use of the eeGeo 3D Maps alongside Apple's MapKit and Google Maps.

The eeGeo 3D Maps API is simple to use and can be dropped unobtrusively into an app. It follows common idioms for mapping APIs, so should be familiar to anyone with prior experience there. This example app can be used as a basis for your own app, or can be used as a reference when integrating eeGeo's maps into an existing app.

## Getting Started 

This section will walk you through the process of getting up and running quickly.

1. Install CocoaPods as described in the [CocoaPods guide](https://guides.cocoapods.org/using/getting-started.html#getting-started).
2. Clone this repo: `git clone git@github.com:eegeo/ios-api-example.git`.
3. Install the eeGeo pod, and other app dependencies by running `pod install` from the repo root.
4. Obtain an [eeGeo API key](https://www.eegeo.com/developers/apikeys) and place it in the [eeGeoApiExample-Info.plist](https://github.com/eegeo/ios-api-example/blob/master/ExampleApp/eeGeoApiExample-Info.plist#L6) file.
5. Open, build, and run **eeGeoApiExample.xcworkspace** in Xcode.

### CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like the eeGeo 3D Maps API in your projects. See the [CocoaPods guide](https://guides.cocoapods.org/) for information about CocoaPods (including installation instructions).

The [eeGeo 3D Maps API CocoaPod](https://cocoapods.org/pods/eegeo) can be used by your project by including the 'eeGeo' pod in your Podfile. This saves having to manually configure and maintain an XCode project which includes the API.

#### Podfiles

A minimal Podfile looks like this:

```ruby
target 'MyApp' do
  pod 'eeGeo'
end
```

The Podfile for this example app looks like this:

```ruby
target :eeGeoApiExample do

    platform :ios, "7.0"

    pod 'eeGeo'
    pod 'GoogleMaps', '1.10.1'
    pod 'FPPopover', '1.4.1'
    
end
```
This Podfile contains the eeGeo pod, as well as other dependencies required for the app. Notice that we do not specify a version for the eeGeo pod; this means that the app will get the latest eeGeo API version when running **pod update**.


### eeGeo API Key 

In order to use the eeGeo 3D Maps API, you must sign up for a free developer account at https://www.eegeo.com/developers. After signing up, you'll be able to create an [API key](https://www.eegeo.com/developers/apikeys) for your apps. 

After signing up for a developer account and creating an API key, add it to the example app [plist file](https://github.com/eegeo/ios-api-example/blob/master/ExampleApp/eeGeoApiExample-Info.plist#L6) as described [above](#getting-started).

If you are creating a new app, or integrating eeGeo 3D Maps into an existing app, the API key should be present in the main bundle info dictionary for the key "eeGeoMapsApiKey" at the time the [EGMapView](https://github.com/eegeo/ios-api/blob/master/src/private/EGMapView.mm) is created.


## API Overview 

There are three main types that the app interacts with when using the eeGeo iOS API, described below: EGMapView, EGMapDelegate, and EGMapApi. For more detailed documentation of the API as a whole, see the [eeGeo CocoaDocs](http://cocoadocs.org/docsets/eeGeo/) page.

### [EGMapView](https://github.com/eegeo/ios-api/blob/master/src/public/EGMapView.h)

The EGMapView is a UIView subclass that can be added to the application view hierarchy. It contains the surface that the eeGeo 3D map is rendered to. Adding a EGMapView to the view hierarchy begins the process of constructing the EGMapApi instance, which will be made available to the application via the EGMapDelegate delegate.

The EGMapView is internally responsible for managing the streaming and drawing of map data, as well as processing touch input to move the camera. From within a ViewController implementing the EGMapDelegate protocol, you can add a view:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eegeoMapView = [[[EGMapView alloc] initWithFrame:self.view.bounds] autorelease];
    self.eegeoMapView.eegeoMapDelegate = self;
    [self.view insertSubview:self.eegeoMapView atIndex:0];
}
```

### [EGMapDelegate](https://github.com/eegeo/ios-api/blob/master/src/public/EGMapDelegate.h)

Adding an EGMapDelegate is important, as the main EGMapApi instance is provided to the app via the delegate. The method to do this is the only required method in the delegate protocol. When the API is ready for use by the app, the EGMapView will call the **eegeoMapReady** method, which should be implemented like so:

```objective-c
- (void)eegeoMapReady:(id<EGMapApi>)api
{
    self.eegeoMapApi = api;

    // App code to handle the API becoming available...
}
```

The EGMapDelegate also provides optional methods to handle events generated by the map, such as the selection and deselection of annotations, as well as various options to customise the behaviour of the map.


### [EGMapApi](https://github.com/eegeo/ios-api/blob/master/src/public/EGMapApi.h) 

The EGMapApi is the main interface through which the app can manipulate the map. It provides methods for drawing polygons, displaying annotations, and changing the theme of the map.

#### Annotations

Adding an annotation is simple:

```
EGPointAnnotation* annotation = [[[EGPointAnnotation alloc] init] autorelease];
annotation.coordinate = CLLocationCoordinate2DMake(37.794851, -122.402650);
annotation.title = @"Three Embarcadero";
annotation.subtitle = @"(Default Callout)";
[self.eegeoMapApi addAnnotation:annotation];
```

The annotation added to the map will show a default callout when selected. The default callout is implemented using the [SMCalloutView](https://github.com/nfarina/calloutview) library, which resembles the familiar built-in MapKit callout. We can handle the selection of the annotation by implementing the EGMapDelegate method:

```
- (void)didSelectAnnotation:(id<EGAnnotation>)annotation
{
    // Add a nice left callout accessory.
    EGAnnotationView* view = [self.eegeoMapApi viewForAnnotation:annotation];
    view.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    printf("Selected annotation with title: %s\n", [[annotation title] UTF8String]);
}
```

Visually, this results in something like:

![Annotation](http://cdn2.eegeo.com/wp-content/uploads/2015/09/annotation.jpg)


#### Themes

The presentation of the map can be changed depending on the theme being used. Themes allow environment textures, lighting parameters, and overlay effects to be modified allowing for significant variation in how the map looks. A collection of preset themes are included, allowing the season, weather, and time of day to be altered. New themes can also be created.

Changing the theme to use an existing preset is simple. Here are a couple of examples:

```objc
// Spring, dawn, rainy weather
EGMapTheme* mapTheme = [[[EGMapTheme alloc] initWithSeason: EGMapThemeSeasonSpring
                                                   andTime: EGMapThemeTimeDawn
                                                andWeather: EGMapThemeWeatherRainy] autorelease];

[self.eegeoMapApi setMapTheme: mapTheme];
```
```objc
// Summer, day-time, clear weather
EGMapTheme* mapTheme = [[[EGMapTheme alloc] initWithSeason: EGMapThemeSeasonSummer
                                                   andTime: EGMapThemeTimeDay
                                                andWeather: EGMapThemeWeatherClear] autorelease];

[self.eegeoMapApi setMapTheme: mapTheme];
```

Many other presets are available, allowing developers to create a distinctive and unique style for their maps.

![Four different seasons, weathers, and times of day](http://cdn2.eegeo.com/wp-content/uploads/2016/03/eegeo-four-seasons-themes.jpg)

## Support

If you have any questions, bug reports, or feature requests, feel free to submit to the [issue tracker](https://github.com/eegeo/ios-api-example/issues) for this repository. Alternatively, you can contact us at [support@eegeo.com](mailto:support@eegeo.com).

## Contributing 

The following step by step guide details the process for contributing to the iOS API.

* First clone the [iOS API source repo](https://github.com/eegeo/ios-api). 
* Download the latest [eeGeo SDK](http://s3.amazonaws.com/eegeo-static/sdk.package.ios.cpp11.tar.gz).
* Link the API and the SDK in the [iOS-api-example](https://github.com/eegeo/ios-api-example) XCode project.
* Expose additional functionality as required.
* Submit a pull request to the [iOS API source repo](https://github.com/eegeo/ios-api) containing the new functionality.
* Submit a pull request to this repo demonstrating the new functionality in the example app.

## License

The eeGeo 3D Maps API is released under the Eegeo Platform SDK Evaluation license. See LICENSE.md for details.
