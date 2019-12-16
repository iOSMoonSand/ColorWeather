# ColorWeather
ColorWeather is a simple, yet playful app built with [SwiftUI](https://developer.apple.com/documentation/swiftui)! It's a personal project that I decided to make public so that anyone can check out the trials and tribulations I had to go through and am still going through to build and ship an app created with SwiftUI to the App Store. Hope you enjoy.

*The most recent committed changes can be found on the `develop` branch. I'm using a git-flow branching system and will merge `develop` into `master` once the MVP version of the app is ready to be shipped to the App Store.*

# 1. Using Sourcery To Store Secrets
ColorWeather uses the [Open Weather Map API](https://openweathermap.org/) to display weather data to users. That being said, I wanted a way to be able to publicly commit the code I wrote while hiding sensitive information like my API key that is needed to make calls to the API. To achieve this, I used a neat little tool called Sourcery.

Amongst other things, [Sourcery](https://github.com/krzysztofzablocki/Sourcery) allows you to generate code dynamically during your app's runtime. I was able to create a bash script that runs in the build phases of the app in order to dynamically generate my API key that remanes safely stored in a local `.xconfig` file of my project. This way I don't have to commit my API key (or any other secrets for that matter) to my public repo making it all the more secure!
