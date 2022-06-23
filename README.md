# DESkooveChallenge
Navigation flow challenge

<p align="center">
  <img src="nav_flow_example_1.gif" height="300">
  <img src="nav_flow_example_2.gif" height="300">
  <img src="nav_flow_example_3.gif" height="300">
</p>

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
