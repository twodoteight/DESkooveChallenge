# DESkooveChallenge
Navigation flow challenge.

### Description
First destination view is determined with a network call that returns the next screen. After the initial seque, an action from the user is needed, after which another transition occurs according to the input. Finally the final screen is showed if the login call (which is made when the app starts) succeded and an appropriate, pre-determined time has passed.

<p align="center">
  <img src="nav_flow_example_1.gif" height="300">
  <img src="nav_flow_example_2.gif" height="300">
  <img src="nav_flow_example_3.gif" height="300">
</p>

### Notes
- Minimum system target: iOS 15.0
- Used Swift version: 5
- MVVM architecture
- Presentation layer with SwiftUI & Combine
- Included some unit tests for the view model

### Disclaimers
P.S. The server code provided for the challenge returns false for every request, every time. At least this was the case for me and I had to change the code a little to get it to return successful responses.

I had to change the line:
```javascript
getRandomInt(1) === 1
```
to:
```javascript
getRandomInt(2)
```
In the function:
```javascript
function processRequest() 
```
