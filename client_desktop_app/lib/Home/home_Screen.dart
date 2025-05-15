import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/CreateReport.dart';

import 'package:myapp_management_desktop/Screens/component_Home_Page/ListOfReport.dart';
import 'package:myapp_management_desktop/Screens/component_Home_Page/profile.dart';
import 'package:myapp_management_desktop/Screens/component_Replys/ListOfReply.dart';
import 'package:myapp_management_desktop/Screens/component_Replys/ReplyScreen.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../Screens/component_Reports/ReportScreen.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var Reportp = Provider.of<ReportScreenData>(context);
    return Container(
      color: kBgLightColor,
      child: Expanded(
        flex: 18,
        child: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 3 : 3,
              child: SideMenu(),
            ),
            Expanded(
                flex: 15,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Expanded(
                              flex: _size.width > 1340 ? 10 : 10,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 350,
                                      child: TextField(
                                        cursorColor: Color(0xFF8793B2),
                                        onChanged: (value) {},
                                        decoration: InputDecoration(
                                          hintText: "بحث في البلاغات",
                                          fillColor: kBgLightColor,
                                          filled: true,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(
                                                kDefaultPadding * 0.75), //15
                                            child: WebsafeSvg.asset(
                                              "assets/Icons/Search.svg",
                                              width: 15,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Text("# مكتب الإدارة ( فريق المراجعة)",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue),),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext) =>
                                                    Profile());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: CircleAvatar(
                                              maxRadius: 24,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  "assets/images/PersonImage.PNG"),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.notifications)),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext) =>
                                                      CreateReport());
                                            },
                                            icon: Icon(Icons.more_vert_rounded))
                                      ],
                                    ),
                                  ]))),
                    ),
                    Expanded(
                      flex: _size.width > 1340 ? 15 : 15,
                      child: Row(
                        children: [
                          Expanded(
                            flex: _size.width > 1340 ? 5 : 5,
                            child: Reportp.choice == 0
                                ? ListOfReport()
                                : ListOfReply(),
                          ),
                          Expanded(
                            flex: _size.width > 1340 ? 10 : 10,
                            child: Reportp.choice == 0
                                ? ReportScreen()
                                : ReplyScreen(),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.only(left: 10, top: 2),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage("assets/svg/images8.jpg"),
            ),
            SizedBox(width: 15),

            //crossAxisAlignment: CrossAxisAlignment.start,

            SizedBox(height: 4),
            Text(
              'إدارة البلاغات ',
              style: TextStyle(
                color: Color.fromARGB(255, 14, 0, 0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '_Software Engineer',
              style: TextStyle(
                color: Color.fromARGB(255, 12, 0, 0),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _SideMenu(BuildContext context) {
    return Container(
      //alignment: AlignmentDirectional.topEnd,
      // width: MediaQuery.of(context).size.width * 0.04,
      width: 100,
      height: 1000,
      color: Color.fromARGB(255, 233, 232, 232),
      alignment: Alignment.center,
      child: ListView(
        children: [
          ListTile(
            title: Text(' '),
            onTap: () {
              // اتخاذ إجراء عند النقر على الصفحة الرئيسية
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            onTap: () {
              // اتخاذ إجراء عند النقر على الصفحة الرئيسية
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            onTap: () {
              // اتخاذ إجراء عند النقر على الإعدادات
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            onTap: () {
              // اتخاذ إجراء عند النقر على الصفحة الرئيسية
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_sharp),
            onTap: () {
              // اتخاذ إجراء عند النقر على الإعدادات
            },
          ),
          // إضافة المزيد من العناصر
        ],
      ),
    );
  }

  Widget _MainContent(BuildContext context) {
    return Container(
      height: 1000,
      color: const Color(0xFFF5F5F5),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          // تعيين صورة الخلفية
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/nodata.gif'),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: [
              ListTile(
                onTap: () {
                  // اتخاذ إجراء عند النقر على الصفحة الرئيسية
                },
              ),
              // إضافة المزيد من العناصر
            ],
          ),
        ),
      ),
    );
  }
}
