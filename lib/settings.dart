import 'package:flutter/material.dart';

class settings extends StatefulWidget {

  @override
  State<settings> createState() => settingsState();
}

class settingsState extends State<settings> {

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setings")),

    );
  }
}