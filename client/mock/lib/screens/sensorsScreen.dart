import 'package:flutter/material.dart';
import 'package:mock/apiService/apiClient.dart';
import 'package:mock/apiService/constans.dart';
import 'package:mock/models/sensors.dart';

class SensorsScreen extends StatefulWidget {
  _SensorsScreenState createState() => _SensorsScreenState();

  ScrollController _scrollController;
}

class _SensorsScreenState extends State<SensorsScreen> {
  List<Sensor> sensors = List<Sensor>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sensor>>(
        future: ApiClient.instance.getSensors(endpoint: SENSOR),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            sensors = snapshot.data;
            return RefreshIndicator(
              onRefresh: _refreshIndicator,
              child: sensorList(sensors, widget._scrollController),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<void> _refreshIndicator() async {
    List<Sensor> snapshot =
        await ApiClient.instance.getSensors(endpoint: SENSOR);
    sensors = snapshot;
  }

  ListView sensorList(List<Sensor> sensors, ScrollController _controller) {
    return ListView.builder(
        controller: _controller,
        itemCount: sensors.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 320,
            height: 120,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(sensors.elementAt(index).icon, size: 50),
                    title: Text(
                      sensors.elementAt(index).name,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      sensors.elementAt(index).value.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
