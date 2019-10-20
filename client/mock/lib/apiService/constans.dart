import 'dart:io';


const String BASE_API = "http://172.16.16.229:5000";

const HOME_API = "http://172.16.16.229:8123/api/states";
const SENSOR = "/sensor.ambient_sensors";


const Map<String, String> HEADER_AUTH = {
  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhMjdkYWM4NTgxYTM0NjJkODI1Mzk3ZGRiNzRmODJiOCIsImlhdCI6MTU3MTIzOTI0MywiZXhwIjoxODg2NTk5MjQzfQ.m0VTX-o2LG3iwPKHshurV-c-wLEcjYzgTNU9Kv0o99Q",
"Content-type": "applicaton/json"
};
const Map<String, String>HEADER_POST = {
  "Content-type" : "application/json"
};


const List<String> SENSORS = ["dust", "humidity", "illuminance", "noise", "temperature"];

