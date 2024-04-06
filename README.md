# WeatherDemoApp

track current weather in real-time.

## Installation:

clone this repo:
https://github.com/ahmed-ibrahim-salim/WeatherDemoApp

-  write in the terminal and execute: <br />

      ```sh
      pod install
      ```

if you are faceing error "Double-quoted include" while building:

- use:
    ```sh
        rm -rf ~/Library/Developer/Xcode/DerivedData/
        rm -rf ~/Library/Caches/CocoaPods/
        pod deintegrate
        pod update
    ```

## Linting
used SwiftLint to enforce code style with warnings & errors

## Used
MVVM, Combine, Realm DB & UI programmatically.

## Unit-Testing
because my schedule was tight, I had no time to add unit tests, but I improved the code to be testable as much as possible by using dependency injection (initialiser & method), so we can use test doubles 
which means we can inject:
- other DB (CoreData) to LocalStorageManager.
- other Database Manager to viewModels. 

