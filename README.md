# SwiftUI-TrackView

<p align="center">
  <img alt="Light" src="https://github.com/akardas16/SwiftUI-TrackView/assets/28716129/cfb84204-f496-4eca-94ef-ee6048ff6f6c" width="32%">
&nbsp; &nbsp; &nbsp; &nbsp;


    
 ```Swift
var orderStatus = ["Preparing","Packaging","On the way","Arrived"]
@State var currentIndex = 2
```
  ```Swift
//Chose your favorite style .reloading or .moving
TrackView(currentIndex: $currentIndex, list: orderStatus, style: .reloading, showLabels: true,selectedColor: .green)
```
