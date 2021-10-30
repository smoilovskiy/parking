import 'package:flutter/material.dart';
import 'package:flutter_app/modules/http.dart';

class EditVehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditVehiclePageState();
  }
}

class EditVehiclePageState extends State<EditVehiclePage> {
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  String response = "";

  editVehicle() async {
    var result = await http_post("edit-vehicle", {
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

    getVehicle() async {
    var result = await http_get('vehicles', {
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
        title: Text("Edit Vehicle"),
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
            child: Text("Edit"),
            onPressed: editVehicle,
          ),
          Text(response),
        ],
      ),
    );
  }
}