import 'dart:typed_data';

import 'package:myapp_management_desktop/Model/Attachment.dart';

import 'package:flutter/material.dart';

class ProViewer extends StatefulWidget {
  Uint8List profile;
  ProViewer(this.profile, {Key? key}) : super(key: key);

  @override
  State<ProViewer> createState() => _ProViewerState();
}

class _ProViewerState extends State<ProViewer> {
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
                      child: Image.memory(widget.profile,
                          fit: BoxFit.fill)),
                ),
              ),
             )));
  }
}
