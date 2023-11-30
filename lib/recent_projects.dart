import 'dart:io';
import 'package:document_generator/scan.dart';
import 'package:flutter/material.dart';
import 'DocsScreen.dart';
import 'project_details.dart';
import 'database.dart';

class Recent_projects extends StatefulWidget {
  @override
  State<Recent_projects> createState() => Recent_projectsState();
}

class Recent_projectsState extends State<Recent_projects> {
  List docsList = [

  ];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Projects'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: docsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (Context)=>projects_details(docsList[index],)));
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(File(docsList[index].image),height:100,width: 100,fit: BoxFit.fill,
                ),
              ),
              title: Text(docsList[index].name,style: TextStyle(fontSize: 25),),
            ),
          );
        },
      ),
    );
  }
  Future<void> getdata() async {
    var abc=await DatabaseHelper().ViewData();
    docsList=abc;
    setState(() {
      print(abc);
    });
  }
}


