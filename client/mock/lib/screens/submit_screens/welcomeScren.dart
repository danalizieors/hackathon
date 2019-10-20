import 'package:flutter/material.dart';
import 'package:mock/apiService/apiClient.dart';
import 'package:mock/apiService/constans.dart';
import 'package:pie_chart/pie_chart.dart';

class WelcomeScreen extends StatefulWidget {
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Map<String, double> dataMap = new Map();

  @override
  void initState() {
    super.initState();
  }

  List<Color> ColorList = [Colors.green, Color.fromARGB(255, 112, 7, 108)];

  void setData(double days) {
    dataMap.putIfAbsent("Healthy", () => 10 - days);
    dataMap.putIfAbsent("Sick", () => days);
  }

  @override
  Widget build(BuildContext context) {
    ApiClient.instance.getSensors(endpoint: SENSOR);
    return FutureBuilder<int>(
      future: ApiClient.instance.daysSick(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          setData(snapshot.data.toDouble());
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ApiClient.response == null
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(bottom: 140.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "We advise that " +
                                ApiClient.response["suggestion"]["text"],
                            style: TextStyle(fontSize: 20),
                          ),
                          listTileBuilder1(),
                          listTileBuilder2(),
                        ],
                      ),
                    ),
              Text(
                "Health in last 10 days",
                style: TextStyle(fontSize: 24),
              ),
              PieChart(
                dataMap: dataMap,
                showChartValuesInPercentage: false,
                colorList: ColorList,
                legendFontSize: 20,
              ),
            ],
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListTile listTileBuilder1() {
    return ListTile(
      leading: Icon(Icons.wb_cloudy, size: 50),
      title: Text(higherOrLower(ApiClient.sent["humidity"],
          ApiClient.response["post"]["humidity"], "humidity")),
      subtitle: Text(oldNew(
          ApiClient.sent["humidity"], ApiClient.response["post"]["humidity"])),
    );
  }

  ListTile listTileBuilder2() {
    return ListTile(
      leading: Icon(Icons.arrow_downward, size: 50),
      title: Text(higherOrLower(ApiClient.sent["pressure"],
          ApiClient.response["post"]["pressure"], "pressure")),
      subtitle: Text(oldNew(
          ApiClient.sent["pressure"], ApiClient.response["post"]["pressure"])),
    );
  }

  String higherOrLower(num valueOld, num valueNew, String sensor) {
    if (valueOld > valueNew)
      return "Current $sensor is to high";
    else
      return "Current $sensor is to low";
  }

  String oldNew(num valueOld, num valueNew) {
    return "old value: " +
        valueOld.toString() +
        " -> better value: " +
        valueNew.toString();
  }
}
