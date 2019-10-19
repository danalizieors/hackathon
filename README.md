# healpal

The healpal project has the goal of finding correlation between various environmental factors and diseases. It consists of two main parts, a mobile application which can query different sources in order to obtain information of the surroundings. The other part is a web server, where this information gets sent by the application and a recommendation for a possible remedy is returned.

This application benefits its clients with these recommendations, but it targets a more noble scope. We can gather a lot of information about the diseases and the environment from the users of this application, based on this data it may be possible to find unforeseen correlations benefiting the entirety of the human race.

## Frontend
The frontend is written in the Dart programming language using Google's new Flutter framework which provides a convenient way of writing cross-platform, high performance, native applications. The design of the application was greatly influenced by Google's Material Design guidelines.

## Backend
The backend web service is written in the Python programming language using Flask. The data science and machine learning was made possible by the Pandas and scikit-learn frameworks. As persistence layer, an abstraction was made over classes containing Pandas data frames, providing the ability to easily serialize and deserialize them in directories, for every data frame in the class producing a JSON encoded file.

## Structure
The project is structured in backend and frontend, also there are some containers made for demonstration and development purposes. The mobile application was built using Android Studio with the necessary plugins installed for Dart and Flutter. The backend's components are containerized with Docker and can be started simultaneously with Docker-Compose.
