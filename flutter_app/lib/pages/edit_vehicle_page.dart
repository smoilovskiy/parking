import 'package:flutter/material.dart';
import 'package:flutter_app/modules/http.dart';

class EditVehiclePage extends StatefulWidget {
  String id, make, model, licensePlate;

  EditVehiclePage(this.id, this.make, this.model, this.licensePlate);
  @override
  State<StatefulWidget> createState() {
    return EditVehiclePageState(this.id, this.make, this.model, this.licensePlate);
  }
}

class EditVehiclePageState extends State<EditVehiclePage> {
  String id, make, model, licensePlate;

  EditVehiclePageState(this.id, this.make, this.model, this.licensePlate);
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  String response = "";

  editVehicle() async {
    var result = await http_post("edit-vehicle", {
      "id": id,
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

  // getVehicle() async {
  //   var result = await http_get('vehicles', {
  //     "make": makeController.text,
  //     "model": modelController.text,
  //     "licensePlate": licensePlateController.text
  //   });
  //   if (result.ok) {
  //     setState(() {
  //       response = result.data['status'];
  //     });
  //   }
  // }

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
            decoration: InputDecoration(hintText: make),
          ),
          TextField(
            controller: modelController,
            decoration: InputDecoration(hintText: model),
          ),
          TextField(
            controller: licensePlateController,
            decoration: InputDecoration(hintText: licensePlate),
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
