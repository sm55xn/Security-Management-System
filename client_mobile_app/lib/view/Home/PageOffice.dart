import 'package:flutter/material.dart';
import 'package:my_security/models/post.dart';
import 'package:my_security/Widgets/post_widget.dart';
import 'package:my_security/Widgets/separator_widget.dart';

class PageOffice extends StatefulWidget {
  PageOffice({Key? key, String? this.profile, String? this.user})
      : super(key: key);
  final profile;
  final user;
  @override
  _PageOfficeState createState() => _PageOfficeState();
}

class _PageOfficeState extends State<PageOffice> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color:
              const Color.fromARGB(255, 161, 107, 107), //change your color here
        ),
        title: const Text(
          'صفحة الرئيسية للمكتب',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: "NeoSansArabic"),
        ),
        actions: [],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 150,
                        padding: EdgeInsets.only(bottom: 100 / 2.2),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.elliptical(10, 10),
                                bottomRight: Radius.elliptical(10, 10)),
                            image: DecorationImage(
                              image: NetworkImage(" "),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // * 3 user Name
                  Container(
                   
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: OutlinedButton.icon(
                              
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  side: BorderSide(color: Colors.blue)),
                              label: Text("متابعة"),
                              icon: Icon(
                                Icons.add,
                                size: 24,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.user,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(""),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    'يهتم هذا الحساب بنشر ارشادات حول استخدام الامثل للبيرمجيات في البيئة اليوم'),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      for (Post post in posts)
                        Column(
                          children: <Widget>[
                            SeparatorWidget(),
                            PostWidget(post: post),
                          ],
                        ),
                      SeparatorWidget(),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 95,
                right: size.width * 0.015,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage("widget.profile"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
