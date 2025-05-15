import 'package:myapp_management_desktop/Model/Attachment.dart';

import 'package:flutter/material.dart';

class imgViewer extends StatefulWidget {
  String url;

  imgViewer(this.url, {Key? key}) : super(key: key);

  @override
  State<imgViewer> createState() => _imgViewerState();
}

class _imgViewerState extends State<imgViewer> {
  @override
  Widget build(BuildContext context) {
  
    Size size = MediaQuery.of(context).size;
    return Dialog(
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            width: size.width * 0.7,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue[100],
                iconTheme: IconThemeData(
                  color: Color.fromARGB(
                      255, 161, 107, 107), //change your color here
                ),
                title: Text(
                  'تصفح الصور',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "NeoSansArabic"),
                ),
                actions: [],
                elevation: 0,
              ),
              body: Container(
                width: size.width,
                height: size.height,
                color: Colors.black,
                child: Center(
                  child: Container(
                      child: Image.network(widget.url,
                          fit: BoxFit.fill)),
                ),
              ),
              floatingActionButton: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: IconButton(
                        onPressed: () {
                         
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: IconButton(
                        onPressed: () {
                         
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )),
                  ),
                ],
              )),
            )));
  }
}
