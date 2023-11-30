import 'package:flutter/material.dart';

import 'Docs_Details.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Docs extends StatefulWidget {
  const Docs({super.key, required this.title});

  final String title;

  @override
  State<Docs> createState() => DocsState();
}

class DocsState extends State<Docs> {
  List docsList = [
    docsStocks(name: "Adharcard",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Pancard",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Driving Licence",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Insurance",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Adharcard2",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Pancard2",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Driving Licence2",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Insurance2",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Adharcard3",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
    docsStocks(name: "Pancard3",img:"https://static.toiimg.com/thumb/msid-60454882,imgsize-50226,width-400,resizemode-4/60454882.jpg"),
  ];

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Documents', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Settings', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (Text("Documents",style: TextStyle(color:Colors.white),)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: docsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                onTap: (){
                  switch("Adharcard"){
                    case "Adharcard":
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Docs_details(title: '', selectedTab: 0, tabbarItems: [1], controller: [TextEditingController()], pdfFile: [null],)));
                      break;
                    case "Pancard":

                      break;
                    case "Driving Licence":

                      break;
                    case "Insurance":

                      break;
                    case "Adharcard2":

                      break;
                    case "Pancard2":

                      break;
                    case "Driving Licence2":
                      break;
                    case "Insurance2":
                      break;
                    case "Adharcard3":
                      break;
                    case "Pancard3":
                      break;
                  }
                },
                leading: Image.network(docsList[index].img,height: 70,width: 70,),
                title: Text(
                  docsList[index].name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: IconButton(icon: Icon(Icons.arrow_forward,), onPressed:null,),
              ),
            ),
          );
        },
      ),
    );
  }
}

class docsStocks {
  String img;
  String name;

  docsStocks({required this.name,required this.img});
}