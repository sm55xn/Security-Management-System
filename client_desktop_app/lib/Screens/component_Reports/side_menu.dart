import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Controller/tags.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:myapp_management_desktop/Screens/component_Reports/SideMenuItem.dart';
import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Reportp = Provider.of<ReportScreenData>(context, listen: true);
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SizedBox(height: kDefaultPadding / 2),
              Text(
                'البـــلاغات',
                style: TextStyle(
                    color: Palette.facebookBlue,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2),
              ),
              Divider(
                height: 3,
              ),
              // Menu Items
              SideMenuItem(
                press: () {
                  Reportp.updateCh(0);
                },
                title: "كل البلاغات الواردة",
                // iconSrc: "assets/Icons/Inbox.svg",
                iconSrc: Icons.inbox,
                isActive: true,
                isHover: Reportp.choice == 0 ? true : false,
                // itemCount: 3,
                showBorder: true,
              ),
              SideMenuItem(
                press: () {
                  Reportp.updateCh(1);
                },
                title: "الردود",
                iconSrc: Icons.forward_to_inbox,
                isActive: true,
                isHover: Reportp.choice == 1 ? true : false,
                showBorder: true,
              ),
              SideMenuItem(
                press: () {
                  Reportp.updateCh(2);
                },
                title: "البلاغات المهمة",
                iconSrc: Icons.label_important_outline_sharp,
                isActive: true,
                isHover: Reportp.choice == 2 ? true : false,
                showBorder: true,
              ),
              SideMenuItem(
                press: () {
                  Reportp.updateCh(3);
                },
                title: "المهملة",
                //iconSrc: "assets/Icons/File.svg",
                iconSrc: Icons.delete_outline,
                isActive: true,
                isHover: Reportp.choice == 3 ? true : false,
                showBorder: true,
              ),

              SizedBox(height: kDefaultPadding * 2),
              // Tags
              Tags(),
            ],
          ),
        ),
      ),
    );
  }
}
