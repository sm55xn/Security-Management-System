import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/CreateReport.dart';
import 'package:myapp_management_desktop/Screens/commonent_verifcation/ListOfRequests.dart';
import 'package:myapp_management_desktop/Screens/commonent_verifcation/VerifiedScreen.dart';
import 'package:myapp_management_desktop/Screens/commonent_verifcation/tabs.dart';

import 'package:myapp_management_desktop/Screens/component_Home_Page/ListOfReport.dart';
import 'package:myapp_management_desktop/Screens/component_Replys/ListOfReply.dart';
import 'package:myapp_management_desktop/Screens/component_Replys/ReplyScreen.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../Screens/component_Reports/ReportScreen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});
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
                                    Text(
                                      'طلبات التوثيق',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2),
                                    ),
                                    Container(child: Tabs(),),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: CircleAvatar(
                                            maxRadius: 24,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: AssetImage(
                                                "assets/images/PersonImage.PNG"),
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
                            flex: _size.width > 1340 ? 4 : 4,
                            child: 
                                  ListOfRequests()
                                
                          ),
                          Expanded(
                            flex: _size.width > 1340 ? 11 : 11,
                            child:
                                 VerifiedScreen()
                                
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
          ],
        ),
      ),
    );
  }
}
