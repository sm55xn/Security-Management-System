import 'package:my_security/view/Home/nav_drawer.dart';
import 'package:my_security/Widgets/CardAvatar.dart';
import 'package:my_security/Widgets/separator_widget.dart';
import 'package:my_security/Widgets/post_widget.dart';
import 'package:my_security/models/post.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Updates extends StatefulWidget {
  // Meet({Key key}) : super(key: key);
  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  CarouselController buttonCarouselController = CarouselController();
  int currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'المستجدات',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            width: 65,
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.notifications,
                size: 34,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: '1',
                    child: Text('1'),
                  ),
                  const PopupMenuItem<String>(
                    value: '2',
                    child: Text('2'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 15.0, top: 10, bottom: 5),
                      child: Text(
                        "الصفحات التي تتابعتها : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  height: 100,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (Post post in posts)
                          Row(
                            children: [
                              Container(
                                child: CardAvatar(user: post.username),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              radius: 35.0,
                              child: Icon(
                                Icons.add,
                                size: 34,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Flexible(
                              child: Text(
                                "إضافة صفحة",
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SeparatorWidget(),
                for (Post post in posts)
                  Column(
                    children: <Widget>[
                      PostWidget(post: post),
                      SeparatorWidget(),
                    ],
                  ),
              ],
            ),
          )),
    );
  }
}
