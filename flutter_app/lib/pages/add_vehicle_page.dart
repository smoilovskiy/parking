import 'package:flutter/material.dart';
import 'package:flutter_app/modules/http.dart';

class AddVehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddVehiclePageState();
  }
}

class AddVehiclePageState extends State<AddVehiclePage> {
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  String response = "";

  createVehicle() async {
    var result = await http_post("create-vehicle", {
      "make": makeController.text,
      "model": modelController.text,
      "licensePlate": licensePlateController.text
    });
    if (result.ok) {
      setState(() {
        response = result.data['status'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Vehicle"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: makeController,
            decoration: InputDecoration(hintText: "Make"),
          ),
          TextField(
            controller: modelController,
            decoration: InputDecoration(hintText: "Model"),
          ),
          TextField(
            controller: licensePlateController,
            decoration: InputDecoration(hintText: "licensePlate"),
          ),
          RaisedButton(
            child: Text("Create"),
            onPressed: createVehicle,
          ),
          Text(response),
        ],
      ),
    );
  }
}
