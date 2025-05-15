import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_security/Widgets/getAttachment.dart';
import 'package:my_security/Widgets/getAttachmentpdf.dart';

// ignore: must_be_immutable
class ReportPage extends StatefulWidget {
  final int index;
  final String idReport;
  final int isAttchment;
  final String type;
  final Color image;
  final String time;
  final String text;
  final String subject;
  final String office;
  bool isstarred;

  ReportPage(
      {required this.index,
      required this.idReport,
      required this.isAttchment,
      required this.type,
      required this.image,
      required this.time,
      required this.text,
      required this.subject,
      required this.office,
      required this.isstarred});
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  GlobalKey _key2 = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstString = 'سوف يتم الرد عليك في اقرب وقت.';

    return Scaffold(
      //key: _key2,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.archive), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //mails.removeAt(widget.index - 1);
                Navigator.pop(context);
              }),
          IconButton(
              icon: Icon(Icons.mail),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              //subject part
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    key: _key2,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 70,
                    child: Text(
                      widget.subject,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              //Mail name part -----> round box
              SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                          color: Colors.green[400], shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          widget.subject[0],
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Row(
                                children: [
                                  Text(
                                    ' إلى > ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                              child: Text(
                                  maxLines: 1,
                                  widget.office,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      const Text(
                                        ' نوع البلاغ : ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(4, 2, 4, 2),
                                          child: Text(
                                              maxLines: 1,
                                              widget.type,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 194, 22, 22),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis)),
                                    ],
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      const Text(
                                        ' الحالة:  ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(4, 2, 4, 2),
                                          child: Text(
                                              maxLines: 1,
                                              widget.type,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 194, 22, 22),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis)),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    children: [
                      //Icon(Icons.more_vert),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: widget.isAttchment == 0
                        ? const Text("لايوجد مرفقات")
                        :  getAttachments(widget.idReport),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: widget.isAttchment == 0
                        ? Text("لايوجد مرفقات")
                        :  getAttachmentpdf(widget.idReport),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    // height: 1000,
                    color: Colors.pink[50],
                    child: Text(
                      firstString,
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              )
            ], //children
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(Icons.reply, "Reply", 1, widget.type, widget.subject,
                  widget.text, widget.time),
              button(Icons.reply_all, "Reply All", 2, widget.type,
                  widget.subject, widget.text, widget.time),
              button(Icons.arrow_forward, "Forward", 3, widget.type,
                  widget.subject, widget.text, widget.time),
            ],
          ),
        ),
      ),
    );
  }

  _getSizes() {
    final renderBoxRed = _key2.currentContext!.findRenderObject() as RenderBox;
    final sizeText = renderBoxRed.size;
    print("SIZE of Text: $sizeText");
  }

  Widget button(IconData icon, String text, int index, String name,
      String subject, String msg, String time) {
    return SizedBox(
      height: 46,
    );
  }
}
