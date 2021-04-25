# Plant Care
An iOS App to supplement the Plant-Care diploma project.

![Mockup-2](https://user-images.githubusercontent.com/57360857/116005883-40fa6400-a609-11eb-9e89-ef86c2db2abb.png)

Plant Care was originally a web application. It was the diploma project developed by 3 of my classmates and me.

## MY ROLE
In the original Plant Care project I was responsible for the backend of the application. I built the entire Rest API which had two main requirements:

 - provide sensor data in real time

 - read/write user information to a MySql database

Multiple challenges had to be overcome to develop the backend. I got introduced to Time Series Databases as well as Server Side Events for the first time in order to present  information in real time.

Next up, I had to ensure the backend is running reliably on a server. For this I used a docker container for each of our components (InfluxDB, MySql database & Java SpringBoot Application). The containers then communicated through a docker network.

## My Personal Project
After the diploma project was done, I decided to build my own iOS App to complement the web app. 
![Mockup-1](https://user-images.githubusercontent.com/57360857/116005870-2f18c100-a609-11eb-8985-31a5800faad3.png)

### Technologies used
I decided to create this project using Apple’s newest framework: SwiftUI. Considering that I have never built a complete iOS App before this one, I picked up lots of new skills while working on Plant-Care:

 - The swift language itself

 - SwiftUI

 - MapKit

 - iOS Charts

![Mockup-3](https://user-images.githubusercontent.com/57360857/116005892-48ba0880-a609-11eb-9052-c749a2fc9ffa.png)
