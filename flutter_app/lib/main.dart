import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_page.dart';

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Parking",
      home: MainPage(),
    );
  }
}
void main(){
  runApp(App());
}