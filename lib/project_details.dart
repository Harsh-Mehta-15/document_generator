import 'dart:io';
import 'package:document_generator/database.dart';
import 'package:flutter/material.dart';

class projects_details extends StatefulWidget {
  UserData pro;
  projects_details(this.pro);


  @override
  State<projects_details> createState() => projects_detailsState();
}

class projects_detailsState extends State<projects_details> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Projects Details'),
      ),
      body:ListView(
        children: [
          SizedBox(height: 40,),
            Center(
                child: Text("${widget.pro.name}",style: TextStyle(fontSize: 25),),
                ),
                SizedBox(height: 20,),
                Image.file(File("${widget.pro.image}"),height: 200,width: 200,)
        ],
      )
    );
  }
}