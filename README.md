# Collections Demo 🚀🚀🚀
Collections Demo is an iOS application designed to showcase a collection of items.
Upon initial launch, the app fetches 20 collections, and users can scroll down to load the next set of 20 collections until all items are displayed.

## Features
1. Collection List View
- Vertical scrollable list of collections retrieved from the Alchemy API.
- Each collection includes a name and image.
- Clicking on a collection opens a detailed view.
- Supports SVG image rendering.
- Displays ETH balance.

2. Collection Detail View
- Displays the selected collection's contract name, image, name, and description.
- Opensea button opens a web page with a permalink to the collection.

## App Demo
![Simulator Screen Recording - iPhone 14 Pro Max - 2024-01-09 at 13 06 26](https://github.com/yulingchen08/CollectionsDemo/assets/6461803/304d2ae6-72fb-4f40-971b-1ff57a9302f6)

## Architecture
- The project follows the MVVM-Coordinator architecture, emphasizing testability and adherence to SOLID principles.

## Development Environment
- iOS 16.2+
- Xcode 15
- Swift 5
  
## Dependencies
- Moya
- RxSwift
- SwiftJSON
- SDWebImage
- Swinject
- SwinjectAutoregistration
- SDWebImageSVGCoder
- SwiftLint
  
## Bonus Features
✅ Utilizes MVVM-C architecture.  
✅ Integrates RxSwift for reactive programming.  
✅ Supports SVG image rendering.  
✅ Displays ETH balance.

## Evaluation Criteria
✅ Understanding of project documentation.  
✅ App usability.  
✅ Code readability.  
✅ High cohesion and low coupling in the code.  
✅ Code testability.  
✅ Bonus features (if implemented).

## Note
UI aesthetics are not a primary evaluation criterion.

## Credits
This app is created by Yuling Chen to demonstrate the use of the Alchemy API.
