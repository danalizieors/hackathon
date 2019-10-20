import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mock/apiService/apiClient.dart';

import '../appState.dart';

class PostSickness extends StatefulWidget {
  _PostSicknessState createState() => _PostSicknessState();
}

class _PostSicknessState extends State<PostSickness> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController _textController = TextEditingController();
  String dropdownValue = null;
  num _sliderValue = 1.0;

  Position _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New symptom"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => App()),
                ModalRoute.withName('/')),
          ),
        ),
        body: FutureBuilder(
            future: ApiClient.instance.getLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _position = snapshot.data;
                return Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70.0, right: 70.0, top: 16.0, bottom: 16.0),
                          child: Column(
                            children: <Widget>[
                              buildDropdownButton(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(70.0),
                          child:
                              dropdownValue == "Other" ? buildTextForm() : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70.0, right: 70.0, top: 40.0, bottom: 40.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "How severe is your symptom?",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              severitySlider(),
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: buildSubmitButton(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }));
  }

  MaterialButton buildSubmitButton() {
    return MaterialButton(
        onPressed: () => ApiClient.instance.post(posted: {
              "user_id": "5",
              "symptom": dropdownValue,
              "severity": _sliderValue,
              "time": DateTime.now().toString(),
              "location": [_position.latitude, _position.longitude],
              "temperature": ApiClient.sensors.elementAt(4).value,
              "pressure": 1019.3,
              "humidity": ApiClient.sensors.elementAt(1).value,
              "wind": 20,
              "in_temperature": ApiClient.sensors.elementAt(4).value,
              "in_humidity": ApiClient.sensors.elementAt(1).value,
              "in_dust": ApiClient.sensors.elementAt(0).value,
              "in_noise": ApiClient.sensors.elementAt(3).value,
              "fitness": 21,
              "pulse": 111,
              "sleep": 76
            }, endpoint: "/advice").whenComplete(() => Navigator.of(context)
                .pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => App()),
                    ModalRoute.withName('/'))),
        color: Color.fromARGB(100, 112, 7, 108),
        textColor: Colors.black,
        child: Text(
          "Submit",
          style: TextStyle(fontSize: 20),
        ));
  }

  Slider severitySlider() {
    return Slider(
      activeColor: Colors.green,
      min: 1.0,
      max: 5.0,
      value: _sliderValue,
      divisions: 4,
      inactiveColor: Color.fromARGB(100, 112, 7, 108),
      label: _sliderValue.toInt().toString(),
      onChanged: (val) {
        setState(() {
          _sliderValue = val;
        });
      },
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      hint: Text("Select your symptom"),
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'Headache',
        'Diarrhea',
        'Flu',
        'Inflamed skin',
        'Eczema',
        'Other'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  TextFormField buildTextForm() {
    return TextFormField(
      controller: _textController,
      decoration: const InputDecoration(
        hintText: 'Tell us about your symptom',
        labelText: 'Symptom/Illness',
        focusColor: Colors.green,
      ),
    );
  }
}

Future<bool> closeApp(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to exit The HealthPal application? "),
            actions: <Widget>[
              FlatButton(
                child: Text("NO"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              FlatButton(
                child: Text("YES"),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          ));
}
