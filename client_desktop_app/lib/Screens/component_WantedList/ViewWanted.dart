import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Model/WantedList.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/ProViewer.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/reports.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/getAttachments.dart';
import 'package:myapp_management_desktop/widget/images_viewer.dart';

class ViewWanted extends StatelessWidget {
  final String id;
  ViewWanted(String this.id);
  final DatabaseService _databaseService = DatabaseService();
  Stream<List<WantedLists>> getWantedList() async* {
    var wantedList = await _databaseService.wantedLists(id);
    yield wantedList;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print('$id');
    ;
    return Dialog(
        child: StreamBuilder<List<WantedLists>>(
            stream: getWantedList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: _size.width * 0.7,
                  child: Scaffold(
                    body: Stack(children: [
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            ClipPath(
                              clipper: MyClip(),
                              child: Container(
                                height: 500.0,
                                color: Colors.deepPurple,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Card(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 300,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              int i = 0;
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext) =>
                                                      ProViewer(
                                                        snapshot
                                                            .data![0].profile,
                                                      ));
                                            },
                                            child: Image.memory(
                                              snapshot.data![0].profile,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "المطلوب/ ",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.red[400],
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${snapshot.data![0].name}",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "2123",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue[300],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        height: 45.0,
                                        width: 150,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: OutlinedButton(
                                            onPressed: (() {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext) =>
                                                      Reports(
                                                        
                                                      ));
                                            }),
                                            style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                            child: Text(
                                              "تصفح البلاغات",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ))),
                                    SizedBox(height: 10.0)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "المقال",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                        fontSize: 22.0),
                                  ),
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                        fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${snapshot.data![0].text}",
                                      style: TextStyle(fontSize: 16.0))),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "المرفقات الإضافية",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: snapshot.data![0].isAttachment == 0
                                  ? Text("لايوجد مرفقات")
                                  : new getAttachments(id),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          )
                        ],
                      ),
                    ]),
                  ),
                );
              } else
                return Text("");
            }));
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 50.0);
    path.quadraticBezierTo(
        size.width - 70.0, size.height, size.width / 2, size.height - 20);
    path.quadraticBezierTo(size.width / 3.0, size.height - 32, 0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(10, size.height / 2 + 20, 5, size.height / 2);
    path.quadraticBezierTo(0, size.height / 3, 10, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
