## Building and running the project (requirements).
* Swift 5.7
* Xcode 14.1 +
* iOS 13.0+

## Setup Configs
- Checkout master branch to run latest version
- Open the terminal.
- Navigate to the project root directory.
- Open the project by double clicking the `BanquemisrChallenge.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app

## Architecture
- This application uses the Model-View-ViewModel (referred to as MVVM) architecture, with (Combine)
the main purpose of the MVVM is to move the data state from the View to the ViewModel.
- (Network part, Load images)  implemented natively using Swift.



## Scenes:
* Group of app scenes: 
- Implement three tabs using native tabBar for displaying (now playing, popular, and upcoming movies).
-  Implement a detail screen that shows comprehensive information about the selected movie.

## About:
- Building an ios app that displays a list of now playing, popular, and upcoming movies from The Movie Database (TMDb) API and allows users to view details of each movie upon clicking.

