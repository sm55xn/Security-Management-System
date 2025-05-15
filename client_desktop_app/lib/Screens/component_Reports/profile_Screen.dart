import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/user_model.dart';

class ProfileC extends StatefulWidget {
  ProfileC({
    Key? key,required User this.user
  }) : super(key: key);
  final User user;
  @override
  _ProfileCState createState() => _ProfileCState();
}

class _ProfileCState extends State<ProfileC> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
        child: Container(
            width: size.width * 0.30,
            height: size.height * 0.80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(10, 10),
                            topRight: Radius.elliptical(10, 10)),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://192.168.43.68:7031/SecMobileV01/img/GetProfile?filename=ca387810-66fc-4c48-8109-73f281401764.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // * 1 backbutton (Row widget)
                    Row(
                      children: [
                        IconButton(
                          color: Colors.white,
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
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('الإسم/ '),
                        Text(
                          "${widget.user.name}",
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
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "رقم الهاتف: ",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${widget.user.phone}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text('درجة المصداقية/  '),
                              Text(
                                "${widget.user.credibility}",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "النوع: ",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${widget.user.gander}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              Text(
                                "تاريخ الميلاد : ",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${widget.user.DateOfBirth}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: size.height * 0.107,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10)),
                      color: Colors.blue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // * post, followers, following, articles
                      Expanded(
                        child: Container(
                          child: ListTile(
                            title: Text(
                              textAlign: TextAlign.center,
                              "${widget.user.reportsCount}",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("عددالبلاغات",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          child: ListTile(
                            title: Text(
                              textAlign: TextAlign.center,
                              "${widget.user.replysCount}",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("عدد الردود",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          child: ListTile(
                            title: Text(
                              textAlign: TextAlign.center,
                              "${widget.user.reportsFakeCount}",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("بلاغات كاذبة",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
