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
