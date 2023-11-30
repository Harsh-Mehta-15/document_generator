import 'dart:async';
import 'dart:io';
import 'package:document_generator/PdfViewerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart' as ps;
import 'scan.dart';

class Docs_details extends StatefulWidget {
  int selectedTab=0;
  List<int> tabbarItems=[1];
  List<TextEditingController> controller=[TextEditingController()];

  List<File?> pdfFile=[null];
  Docs_details({super.key, required this.title,required this.selectedTab,required this.tabbarItems,required this.controller,required this.pdfFile});

  final String title;

  @override
  State<Docs_details> createState() => Docs_detailsState();
}

class Docs_detailsState extends State<Docs_details>  with SingleTickerProviderStateMixin{

 late TabController tabcontroler ;
  int selectedTab=0;
  List<int> tabbarItems=[1];
  List<TextEditingController> controller=[TextEditingController()];

  List<File?> pdfFile=[null];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTab=widget.selectedTab;
    tabbarItems=widget.tabbarItems;
    controller=widget.controller;
    pdfFile=widget.pdfFile;
    tabcontroler = TabController(length: tabbarItems.length, vsync: this);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    var file ;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.add),
            onPressed: (){
              var length=tabbarItems.length;
              length++;
              setState(() {
                tabbarItems.add(length);
                // tabcontroler.se;
                controller.add(TextEditingController());
                pdfFile.add(null);
              });
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Docs_details(title: "title", selectedTab: selectedTab, tabbarItems: tabbarItems, controller: controller, pdfFile: pdfFile,)));
              print(tabbarItems);
            },
          ),
        ],
      ),
      body: DefaultTabController(
          length: tabbarItems.length,
          child: Column(
            children: [

              TabBar(
                controller: tabcontroler,
                onTap: (index){
                  setState(() {
                   selectedTab=index;
                  });
                },
                  isScrollable: true,
                  labelColor: Colors.red,
                  tabs: List.generate(tabbarItems.length, (index) => Tab(text: "${index+1}",))),
              Expanded(
                child: TabBarView(
                  controller: tabcontroler,
                  //physics: NeverScrollableScrollPhysics(),
                  children: List.generate(tabbarItems.length, (index) => tabbarviewItem(index)),
                ),
              ),
              ElevatedButton( onPressed: () {
                tabbarItems.removeAt(tabcontroler.index);
                controller.removeAt(tabcontroler.index);
                setState(() {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Docs_details(title: "title", selectedTab: selectedTab, tabbarItems: tabbarItems, controller: controller, pdfFile: pdfFile)));
                });
              },
              child: Text('Delete Tab')),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: ElevatedButton(child: Text('Scan',style: TextStyle(color: Colors.black)),
                      onPressed: ()async{
                        final result = await Navigator.push(
                            context, MaterialPageRoute(builder: (context)=>scan(title: '')));
                        result!=null? controller[tabcontroler.index].text=result.toString():null;
                        setState(() {
                        createFile();
                        });
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white12),)),
                ),
              ),
             ElevatedButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (_)=>PdfViewerScreen(controller)));

              }, child: Text("View Pdf"),),
              SizedBox(height: 20,)
            ],

          )
      ),
    );
  }

  tabbarviewItem(int index){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 10),
            child: SizedBox(
              height: 10,
              child: TextField(
                controller: controller[index],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabled: true,

                ),
                textAlign: TextAlign.start,
                showCursor: true,
                cursorColor: Colors.black,

                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                //expands: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void createFile()async
  {
    final pdf = pw.Document();
    await  ps.Permission.manageExternalStorage.request();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(controller[selectedTab].text),
          ); // Center
        }));
    final output = await getApplicationDocumentsDirectory();
    var file =await File("${output.path}/${DateTime.now().microsecondsSinceEpoch}.pdf").create(recursive: true);
    await file.writeAsBytes(await pdf.save());
    pdfFile[selectedTab]=file;
    setState(() {

    });
  }

}
