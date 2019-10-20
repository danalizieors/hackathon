import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mock/models/sensors.dart';

import 'constans.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  http.Client _client;

  //GLOBAL PRIVATE VARIABLE XD
  static Map<String, dynamic> _response;

  static Map<String, dynamic> get response => _response;

  static ApiClient get instance => _instance;

  static List<Sensor> _sensors;

  static Map<String, dynamic> _sent;

  static Map<String, dynamic> get sent => _sent;

  Position _position;

  ApiClient._internal() {
    _client = http.Client();
  }

  Future<void> post({Map<String, dynamic> posted, String endpoint = ""}) async {
    var response;
    _sent = posted;
    try {
      response = await _client.post(BASE_API + endpoint,
          headers: HEADER_POST, body: jsonEncode(posted));
      response = jsonDecode(response.body);
      _response = response;
      print(_response);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> postAdvice(
      {Map<String, dynamic> posted, String endpoint = ""}) async {
    var response;

    try {
      response = await _client.post(BASE_API + endpoint,
          headers: HEADER_POST, body: jsonEncode(posted));
    } on Exception catch (e) {
      print(e);
    }
    print(response.body);
    _response = jsonDecode(response.body);
    try {
      var res =
          await _client.post('http://hrothgar32.pythonanywhere.com/add_cord');
    } on Exception catch (e) {
      print(e);
    }
    print(_response);
    return _response;
  }

  static List<Sensor> get sensors => _sensors;

  Future<int> daysSick() async {
    var response;
    try {
      response = await _client.get(BASE_API + "/posts?user_id=5",
          headers: HEADER_AUTH);
      response = jsonDecode(response.body);
    } on Exception catch (e) {
      print(e);
    }
    print(response.length);
    return response.length;
  }

  Future<Map<String, dynamic>> getUserData() async {
    var response;
    try {
      response = await _client.get(HOME_API + "users", headers: HEADER_AUTH);
      Map<String, dynamic> res = jsonDecode(response.body);
      return res;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Sensor>> getSensors({String endpoint = ""}) async {
    var response;
    try {
      response = await _client.get(HOME_API + endpoint, headers: HEADER_AUTH);
      Map<String, dynamic> res = jsonDecode(response.body);
      List<Sensor> sensors = [];

      // print(res["attributes"].runtimeType);
      res["attributes"].forEach((k, v) {
        if (SENSORS.contains(k)) {
          sensors.add(
            Sensor(name: k, value: v, icon: getIcon(k)),
          );
        }
      });
      // sensors.forEach((e) => print(e.name + e.value.toString()));
      _sensors = sensors;
      return sensors;
    } on Exception catch (e) {
      print(e);
    }
    return _sensors;
  }

  IconData getIcon(String name) {
    switch (name) {
      case "humidity":
        return Icons.wb_cloudy;
      case "temperature":
        return Icons.wb_sunny;
      case "dust":
        return Icons.blur_circular;
      case "sleep":
        return Icons.local_hotel;
      case "illuminance":
        return Icons.lightbulb_outline;
    }
    return Icons.all_out;
  }

  Future<Position> getLocation() async {
    _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return _position;
  }
}
