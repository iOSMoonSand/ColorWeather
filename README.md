# ColorWeather
ColorWeather is a simple, yet playful app built with [SwiftUI](https://developer.apple.com/documentation/swiftui)! It's a personal project that I decided to make public so that anyone can check out the trials and tribulations I had to go through and am still going through to build and ship an app created with SwiftUI to the App Store. Hope you enjoy.

*The most recent committed changes (not yet on the App Store) can be found on the `develop` branch. I'm using a git-flow branching system.*


Here are some screenshots of the current `develop` version that is not yet visible on the App Store because of a bug in the SwiftUI framework itself that is not letting me get the new version approved by the App Store Review team:


<img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3.jpg?raw=true" width="250"/> <img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3%20(1).jpg?raw=true" width="250"/> <img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3%20(2).jpg?raw=true" width="250"/> <img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3%20(3).jpg?raw=true" width="250"/> <img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3%20(4).jpg?raw=true" width="250"/> <img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3%20(5).jpg?raw=true" width="250"/> <img src="https://github.com/iOSMoonSand/ColorWeather/blob/master/appstore-screenshots/0x0ss-P3%20(6).jpg?raw=true" width="250"/>

<br>

**Some Highlights of the App:**

# 1. Using Sourcery To Store Secrets
ColorWeather uses the [Open Weather Map API](https://openweathermap.org/) to display weather data to users. That being said, I wanted a way to be able to publicly commit the code I wrote while hiding sensitive information like my API key that is needed to make calls to the API. To achieve this, I used a neat little tool called Sourcery.

Amongst other things, [Sourcery](https://github.com/krzysztofzablocki/Sourcery) allows you to generate code dynamically during your app's runtime. I was able to create a bash script that runs in the build phases of the app in order to dynamically generate my API key that remanes safely stored in a local `.xconfig` file of my project. This way I don't have to commit my API key (or any other secrets for that matter) to my public repo making it all the more secure!

# 2. Networking
The networking layer was done without using any third party libraries, using the good ol' `URLSession`. I created a web client to take care of creating data tasks and retrieving data received from requests. A service class was also created to interface with the client. It initiates requests specific to Open Weather Map's API and returns data that it subsequently turns into models readable by the UI layer. Without the service class, the client is a generic stand-alone object that is independent of any one specific API's endpoints.

# 3. Unified Logging
With Apple's [unified logging system](https://developer.apple.com/documentation/os/logging) and using `OSLog` objects, I was able to create an elaborate yet performant logging system. Benefits of using this system:
* Set different levels of log persistence: messages of higher importance get persisted to disk which allows viewing production logs, less important information is saved in memory and is more useful for debug environments.
* Increase your app's performance by using a native Apple library for logging rather than polluting your code with countless `print`/`NSLog` statements.
* Supports categories to allow you to easily organize and find logs.
* Supports emojis ❌🔵🛠!

This logging system was extremely helpful and helped me debug complex bugs that would have taken me much longer to figure out without it!

# 4. Search Suggestions
When a user types to add a new city for which they want the weather, a list of suggested cities gets populated as they type. This was done with the help of Apple's [MKLocalSearchCompleter](https://developer.apple.com/documentation/mapkit/mklocalsearchcompleter), a great class from the `MapKit` library which returns suggested geographic locations from the fragments of text typed in the search bar. With SwiftUI's stateful properties, I was able to create a fluid UI that automatically regerates itself as the user types.

# 5. Core Location
In order to transform human readable addresses into geographic coordinates (latitude/longitude) I used Apple's [CLGeocoder](https://developer.apple.com/documentation/corelocation/clgeocoder) which is part of the `Core Location` library. This allowed me to retrieve coordinates which were then used as parameters in my web requests to the Open Weather Map API.

# 6. Unit Tests
No app is complete without writing bug-catching unit tests! Some of the more complex test cases were the network layer tests. It can be difficult to test this layer since its code is often asynchronous and it has an important dependency: the Internet! In order to get this done I created a mock `URLProtocol`. When we create a `URLSession` to initiate web requests, the session looks for what are called protocol handlers to know how to proceed with its tasks. By creating my own, passing it to the session object and injecting the session into the client, I was able to simulate a web service success and failure with mocked data in order to test my web client without having to connect to the Internet! This also avoids having to subclass `URLSession` which is another common (more tedious IMHO) approach to network layer unit tests.
