import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  var name="name";
  var image="image";
  var project_id="project_id";
  var date_added="date_added";
  var date_modified="date_modified";

  Future<String> initDatabase() async {
    var databasesPath = await getDatabasesPath();

    var path = join(databasesPath, "doc.db");

    // Check if the database exists

    var exists = await File(path).exists();

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}


      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "doc.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      var datas=await File(path).writeAsBytes(bytes, flush: true);
      print(datas.path);
    } else {
      print("Reading Existing Database");
    }
    // open the database
    await openDatabase(path);

    return path;
  }

  initData(Map<String,dynamic> value)async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'doc.db');
    var database=await openDatabase(path,readOnly: false);
    var result=await database!.insert('projects', value );
    print(" result $result");
  }

  Future<List<UserData>> ViewData() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'doc.db');
    var database=await openDatabase(path,readOnly: false);
    var result=await database!.rawQuery("select * from projects");
    List<UserData> users=[];

    if(result.length!=0){
      for(var i=0;i<result.length;i++){
        Map<String,dynamic> data=result[i];
        print(data);

        users.add(UserData(data[name],data[image],data[project_id],data[date_added],data[date_modified]));
      }
      return users;
    }else{
      return users;
    }
  }
}
class UserData{
  String name,image,date_added,date_modified;
  int project_id;

  UserData(this.name,this.image,this.project_id,this.date_added,this.date_modified );
}


