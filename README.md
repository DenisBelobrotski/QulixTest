# QulixTest
I'm using Xcode 9 and Swift 4.
## If you want to run this project:
1. Download this project.
2. Install [CocoaPods](https://cocoapods.org).
3. Include in project [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftGif](https://github.com/bahlo/SwiftGif) using CocoaPods. My Podfile:
```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'QulixTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 4.5'
  pod 'SwiftGifOrigin', '~> 1.6.1'

  # Pods for QulixTest

end
```
4. After installing close project and open ```QulixTest.xcworkspace``` (not ```QulixTest.xcodeproj```).
5. Clean (```Product~>Clean```) and run (```Product~>Run```) project.
