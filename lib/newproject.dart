import 'dart:io';
import 'package:document_generator/Common.dart';
import 'package:flutter/material.dart';
import 'package:document_generator/image.dart';
import 'package:image_picker/image_picker.dart';

import 'DashBoardScreen.dart';
import 'database.dart';
class New extends StatefulWidget {
  @override
  State<New> createState() => NewState();
}

class NewState extends State<New> {
  XFile? image1 ;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Documents', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Settings', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),];

  var project_nm =TextEditingController();


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Project"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: project_nm,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: ' Name ',
              ),
            ),
          ),
          image1==null?GestureDetector(
            onTap: ()async{
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ElevatedButton(onPressed: ()async{
                            Navigator.pop(context);
                            final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                            if(image!=null){
                              image1=image;
                              setState(() {

                              });
                            }
                          }, child: Text("Camera")),
                          ElevatedButton(
                            child: const Text('Gallery'),
                            onPressed:()async{
                              Navigator.pop(context);
                            final XFile? camera = await ImagePicker().pickImage(source: ImageSource.gallery);
                           if(camera!=null){
                             image1=camera;
                             setState(() {

                             });
                           }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top:16),
                    child: SizedBox(
                      height: 200,width: 200,
                      child:Container(
                        decoration: BoxDecoration(

                           // borderRadius: BorderRadius.circular(100),
                            color: Colors.grey[300]
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                  SizedBox(height: 14,),

                ],
              ),
            ),
          ):Container(
            height: 200,width: 200,
            child: Stack(
              children: [
                Image.file(File(image1!.path),height: 200,width: 200,),
                Positioned(child: GestureDetector(
                    onTap: (){
                      image1=null;
                      setState(() {

                      });
                },
                    child: Icon(Icons.cancel,color: Colors.red,)))
              ],
            ),
          ),
          Spacer(),
          Container(
              height: 50,
              width: 500,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text("Save",),
                onPressed: () {
                  if(project_nm.text.isNotEmpty && image1!=null){
                  Map<String,dynamic> data={
                    "name" : project_nm.text,
                    "image" : image1!.path,
                    "date_added" : DateTime.now().toString(),
                    "date_modified" : DateTime.now().toString(),
                  };
                  DatabaseHelper().initData(data);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>DashBoardScreen()));
                  }
                  else{
                    final snackBar = SnackBar(
                      content: const Text('Please Fill the Name and Photo'),
                      action: SnackBarAction(
                       label: 'Okay',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              )
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
}
}
