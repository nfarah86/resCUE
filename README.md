# resCUE

1. [Synopsis](#synopsis)

2. [Project Information](#project-information)

3. [Technologies Used](#technologies-used)

4. [License](#license)

## Synopsis

resCUE is a platfrom in development to help you keep in touch when it matters most.

This project was inspired while running and feeling endagendered by my surroundings. After texting some friends and letting them know where I was, I thought there had to be a safer way to leverage technology to solve this problem. 

Combining wearable Bluetooth LE hardware, an iOS app, and a cloud backend, resCUE tracks your location in real-time. After activated, resCUE continues to update your contacts in realtime.  

resCUE is designed to be easy to use and reliable. Compared to typing one text message, resCUE is 3x's faster in sending multiple messages. A single click initiates a broadcast call to the contacts letting them know when you started and ended your activity. By holding down the button for more than three seconds, emergency mode is initiated, letting your contacts know when you need help immediately. 

With resCUE, peace of mind is one click away. 

## Project Information
This project is divided into three components:
   
* resCUE_arduino/ (Arduino sketch)   
* resCUE_client/ (iOS App)   
* resCUE_server/ (cloud server)

## Technologies Used
* LightBlue Bean microcontroller
* Low Energy Bluetooth (BTLE)
* Obj-C (native iOS app)
* Python 2.7
* JavaScript
* Flask 
* Postgres
* MapBox API
* Twilio API
* Heroku

## License
Private end-user license agreement