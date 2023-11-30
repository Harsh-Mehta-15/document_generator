import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart' as ps;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatefulWidget{
  List<TextEditingController> list=[];
  PdfViewerScreen(this.list);

  @override
  State<StatefulWidget> createState()=>PdfViewerScreenState();


}

class PdfViewerScreenState extends State<PdfViewerScreen> {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  File? pdfFile;

  int selectedTab=0;
  List<TextEditingController> controller=[TextEditingController()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crweatefgile();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () async {
                  final pdf = pw.Document();
                  await  ps.Permission.manageExternalStorage.request();
                  var controller=widget.list;
                  for(var i in controller){
                    pdf.addPage(pw.Page(
                        pageFormat: PdfPageFormat.a4,
                        build: (pw.Context context) {
                          return pw.Center(
                            child: pw.Text(i.text),
                          ); // Center
                        }));


                  }
                  final output = await getApplicationDocumentsDirectory();
                  var file =await File("${output.path}/${DateTime.now().microsecondsSinceEpoch}.pdf").create(recursive: true);
                  await file.writeAsBytes(await pdf.save());

                  var d=await File("/storage/emulated/0/Downloads/${basename(file!.path)}").create(recursive:true);
                  pdfFile!.copy(d.path);
                },
                  child: InkWell(
                    onLongPress: () {},
                    child: Ink(
                      child: Icon(Icons.download, size: 26.0,
                      ),
                    ),
                  ),
                /*child: Icon(
                  Icons.download,
                  size: 26.0,
                ),*/
              )
          ),
        ],
      ),
        body: pdfFile==null?Container():PDFView(
          filePath: pdfFile!.path,
          // enableSwipe: false,
          onRender: (_pages) {
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (int? page, int? total) {
            print('page change: $page/$total');
          },
        )
    );
  }

  void crweatefgile()async {
    final pdf = pw.Document();
    await  ps.Permission.manageExternalStorage.request();
  for(var i in widget.list){
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(i.text),
          ); // Center
        }));
  }
    final output = await getApplicationDocumentsDirectory();
    var file =await File("${output.path}/${DateTime.now().microsecondsSinceEpoch}.pdf").create(recursive: true);
    await file.writeAsBytes(await pdf.save());
    pdfFile=file;
    setState(() {

    });
      }
}
