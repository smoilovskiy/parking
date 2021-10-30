import 'package:flutter/material.dart';
import 'package:flutter_app/modules/http.dart';
import 'package:flutter_app/pages/add_vehicle_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class Vehicle {
  String id;
  String make;
  String model;
  String licensePlate;
  Vehicle(this.id, this.make, this.model, this.licensePlate);
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    refreshVehicles();
  }

  List<Vehicle> vehicles = [];
  Future<void> refreshVehicles() async {
    var result = await http_get('vehicles');
    if (result.ok) {
      setState(() {
        vehicles.clear();
        var in_vehicles = result.data as List<dynamic>;
        in_vehicles.forEach((in_vehicle) {
          vehicles.add(Vehicle(in_vehicle['id'].toString(), in_vehicle['make'],
              in_vehicle['model'], in_vehicle['licensePlate']));
        });
      });
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicles"),
        actions: <Widget>[
          FlatButton(
            onPressed: refreshVehicles,
            child: Text('Refresh'),
          ),
          FlatButton(
            child: Text('Add vehicle'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddVehiclePage();
              }));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshVehicles,
        child: ListView.separated(
          itemCount: vehicles.length,
          itemBuilder: (context, i) => ListTile(
            leading: Icon(Icons.car_rental),
            title: Text(vehicles[i].make),
            subtitle: Text(vehicles[i].model),
            // trailing: Text(vehicles[i].licensePlate),
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                Text(vehicles[i].licensePlate),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          separatorBuilder: (context, i) => Divider(),
        ),
      ),
    );
  }
}
