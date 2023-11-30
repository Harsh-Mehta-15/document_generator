import 'dart:async';
import 'dart:developer';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:flutter/material.dart';


class scan extends StatefulWidget {
  const scan( {super.key, required this.title});
  final String title;

  @override
  State<scan> createState() => scanState();
}

class scanState extends State<scan> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setText(value) {
    controller.add(value);
  }
  bool showQr=true;

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  <Widget>[
              showQr?ScalableOCR(
                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color.fromARGB(153, 102, 160, 241),
                  boxLeftOff: 5,
                  boxBottomOff: 5,
                  boxRightOff: 5,
                  boxTopOff: 5,
                  //boxHeight: MediaQuery.of(context).size.height/2,
                  boxHeight: 450,
                  getRawData: (value) {
                    // Navigator.pop(context,value);
                    inspect(value);
                  },
                  getScannedText: (value) {
                    setText(value);
                  }):Container(),
                 StreamBuilder<String>(
                stream: controller.stream,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Result(text: snapshot.data != null ? snapshot.data! : "");
                },
              ),
            ],
          ),
        ));
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    //var txtfd;
    return Column(
      children: [
        Text("Readed text: $text"),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: (){ Navigator.pop(context,text);}, child: Text("Done"))
      ],
    );
  }
}