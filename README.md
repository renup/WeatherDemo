# WeatherDemo
This app is to demo Weather App built using SwiftUI and UIKit using MVVM architecture and Unit tests

Coding Challenge: Weather
A weather based app where users can look up weather for a city.

Public API used: https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key}

Built-in geocoding uses Geocoder API to automatically convert city names and zip-codes to geo coordinates and the other way around.

Please note that API requests by city name, zip-codes and city id have been deprecated. Although they are still available for use, bug fixing and updates are no longer available for this functionality.

Built-in API request by city name, state code and country code. Please note that searching by states available only for the USA locations.

API call

https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

https://api.openweathermap.org/data/2.5/weather?q={city name},{country code}&appid={API key}

https://api.openweathermap.org/data/2.5/weather?q={city name},{state code},{country code}&appid={API key}

 

Using icons from here:

http://openweathermap.org/weather-conditions

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 

Implementation:

Search Screen

Allows customers to enter a US city

Calls the openweathermap.org API and displays the weather information and a weather icon.

Auto-loads the last city searched upon app launch.

Asks the User for location access, If the User gives permission to access the location, then retrieves weather data by default


Coding mindset:

Well-constructed, easy-to-follow, commented code.

Proper separation of concerns and best-practice coding patterns.

Defensive code that graciously handles unexpected edge cases.

Unit Tests

Industry-standard design pattern adoption (MVVM)

Adoption of SOLID principles. 

A combination of both UIKit and SwiftUI.
