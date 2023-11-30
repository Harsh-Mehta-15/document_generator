import 'dart:io';
import 'package:document_generator/newproject.dart';
import 'package:document_generator/project_details.dart';
import 'package:document_generator/recent_projects.dart';
import 'package:flutter/material.dart';
import 'Common.dart';
import 'database.dart';
import 'home.dart';

class DashBoardScreen extends StatefulWidget{

  DashBoardScreen();

  @override
  State<StatefulWidget> createState() =>DashBoardScreenState();

}

class DashBoardScreenState extends State<DashBoardScreen> {
  List docsList = [

  ];
  @override
  void initState() {
    super.initState();
    getdata();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //greeting
          Text(greeting()+" : Dhaval",style:TextStyle(fontSize: 30)),
          //recent text
          SizedBox(height: 100,),

          Row(
            children: [
              Text("Recent Project",style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
              Spacer(),
              TextButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Recent_projects()));
              },
                child: Text("View All",style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
            ],
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: docsList.length>3?3:docsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>projects_details(docsList[index])));
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                            children: [
                              Image.file(File(docsList[index].image),height:170,width: 200,),
                              Text(docsList[index].name,style: TextStyle(fontSize: 25),)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Spacer(),
          Container(
              height: 50,
              width: 500,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text("NEW  PROJECT",),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>New()));
                },
              )
          ),
          SizedBox(height: 50,)
        ],
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