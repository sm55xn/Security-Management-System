import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/post_container.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, String? this.profile, this.page}) : super(key: key);
  final profile;
  final page;
  @override
  _ProfileCState createState() => _ProfileCState();
}

class _ProfileCState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ReportScreenData>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child:  Container(
            width: size.width * 0.7,
            
            decoration: BoxDecoration(
                color: Colors.transparent, borderRadius: BorderRadius.circular(1)),
            child: Scaffold(
        body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            color: Colors.blue,
                            height: 200,
                            padding: EdgeInsets.only(bottom: 100 / 2.2),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.elliptical(10, 10),
                                    bottomRight: Radius.elliptical(10, 10)),
                                image: DecorationImage(
                                  image: NetworkImage(""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
        
                          // * 1 backbutton (Row widget)
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
        
                          // * user profile image
                        ],
                      ),
                      // * 3 user Name
                      Container(
                        height: 200,
                        color: Colors.white70,
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.page.Name,
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
                                //  Text("@Sameh.ye"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.page.Description,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                      ),
                      Row(
                        children: [
                          // * post, followers, following, articles
                          Expanded(
                            child: Container(
                              child: ListTile(
                                title: Center(
                                    child: Text(
                                  '${widget.page.PostsCount}',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )),
                                subtitle: Center(child: Text("المنشورات")),
                              ),
                            ),
                          ),
        
                          Expanded(
                            child: Container(
                              child: ListTile(
                                title: Center(
                                    child: Text(
                                  "12",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )),
                                subtitle: Center(child: Text("التعليقات")),
                              ),
                            ),
                          ),
        
                          Expanded(
                            child: Container(
                              child: ListTile(
                                title: Center(
                                    child: Text(
                                  "4",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )),
                                subtitle: Center(child: Text("الإعجابات")),
                              ),
                            ),
                          ),
        
                          Expanded(
                            child: Container(
                              child: ListTile(
                                title: Center(
                                    child: Text(
                                  "3",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )),
                                subtitle: Center(child: Text("المتابعين")),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var post in p.PostsInPage) Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                        child: PostContainer(post: post),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 145,
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
                        backgroundImage: NetworkImage(
                            "https://192.168.43.68:7031/SecMobileV01/img/GetProfile?filename=${widget.profile}.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
