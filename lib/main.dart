import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().initDatabase();
  runApp(const MyLogin());
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  // This widget is the root of your application.
  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child:Column(
                children: [
                  
                  Image.network("https://5.imimg.com/data5/HT/JR/TW/GLADMIN-60238/ocr-software-250x250.jpeg",height: 250,),
                ],
              )),
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name ',
              ),
            ),
          ),
          Container(
            height: 90,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text("Login",),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  }
                 /*if(nameController.text=="123" && passwordController.text=="123") {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));}*/
                  else {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill input')));
                  }
                }
              ),
          ),
      ],
      ));
  }
}