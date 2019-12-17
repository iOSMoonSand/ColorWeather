# ColorWeather
ColorWeather is a simple, yet playful app built with [SwiftUI](https://developer.apple.com/documentation/swiftui)! It's a personal project that I decided to make public so that anyone can check out the trials and tribulations I had to go through and am still going through to build and ship an app created with SwiftUI to the App Store. Hope you enjoy.

*The most recent committed changes can be found on the `develop` branch. I'm using a git-flow branching system and will merge `develop` into `master` once the MVP version of the app is ready to be shipped to the App Store.*

# 1. Using Sourcery To Store Secrets
ColorWeather uses the [Open Weather Map API](https://openweathermap.org/) to display weather data to users. That being said, I wanted a way to be able to publicly commit the code I wrote while hiding sensitive information like my API key that is needed to make calls to the API. To achieve this, I used a neat little tool called Sourcery.

Amongst other things, [Sourcery](https://github.com/krzysztofzablocki/Sourcery) allows you to generate code dynamically during your app's runtime. I was able to create a bash script that runs in the build phases of the app in order to dynamically generate my API key that remanes safely stored in a local `.xconfig` file of my project. This way I don't have to commit my API key (or any other secrets for that matter) to my public repo making it all the more secure!

# 2. Networking
The networking layer was done without using any third party libraries, using the good ol' `URLSession`. I created a web client to take care of creating data tasks and retrieving data received from requests. A service class was also created to interface with the client. It initiates requests specific to Open Weather Map's API and returns data that it subsequently turns into models readable by the UI layer. Without the service class, the client is a generic stand-alone object that is independent of any one specific API's endpoints.

# 3. Unified Logging
With Apple's [unified logging system](https://developer.apple.com/documentation/os/logging) and using `OSLog` objects, I was able to create an elaborate yet performant logging system. Benefits of using this system:
* Set different levels of log persistence: messages of hire importance get persisted to disk which allow viewing production logs, less important information is saved in memory and is more useful for a debug environment.
* Increase your app's performance by using a native Apple library for logging rather than polluting your code with countless `print`/`NSLog` statements.
* Supports categories to allow you to easily organize and find logs.
* Supports emojis "❌", "🔵", "🛠" !

This logging system was extremely helpful and helped me debug complex bugs that would have taken me much longer to figure out without it!
