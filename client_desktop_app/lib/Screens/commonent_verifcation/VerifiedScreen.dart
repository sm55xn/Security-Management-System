import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';

import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/commonent_verifcation/header.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/Reply.dart';

import 'package:myapp_management_desktop/Screens/component_Reports/profile_Screen.dart';
import 'package:myapp_management_desktop/Service/api/GetReports.dart';
import 'package:myapp_management_desktop/widget/getAttachments.dart';

import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class VerifiedScreen extends StatelessWidget {
  VerifiedScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController replyBady = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("ReportScreen");
    var Reportp = Provider.of<ReportScreenData>(context);
    
    return Reportp.readdata != null?Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: SafeArea(
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderX(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  Reportp.readdata![Reportp.index].subject!,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 1,
                  color: kBgLightColor,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        hoverColor: const Color.fromARGB(0, 255, 255, 255),
                        onPressed: ()async {
                          await getInfoProfile(Reportp.readdata![Reportp.index].phone!).then((value) =>  showDialog(
                                    context: context,
                                    builder: (BuildContext) => ProfileC( user: value,)));
                        },
                        icon: CircleAvatar(
                          maxRadius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: Reportp
                                              .readdata![Reportp.index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  Reportp.readdata![Reportp.index].time,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding * 2),
                            LayoutBuilder(
                              builder: (context, constraints) => SizedBox(
                                width: constraints.maxWidth > 850
                                    ? 800
                                    : constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Reportp.readdata![Reportp.index].body,
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Color(0xFF4D5875),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding),
                                    Divider(
                                      thickness: 1,
                                      color: kBgLightColor,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          " مرفقات",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spacer(),
                                        Text(
                                          "تنزبل الكل ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(width: kDefaultPadding / 4),
                                        ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              kGrayColor, BlendMode.srcIn),
                                          child: WebsafeSvg.asset(
                                            "assets/Icons/Download.svg",
                                            height: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Reportp.readdata![Reportp.index]
                                                  .isAttachmentAvailable ==
                                              0
                                          ? Text("لايوجد مرفقات")
                                          : new getAttachments(Reportp
                                              .readdata![Reportp.index].id),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 85,
                  width: double.infinity,
                  child: TextField(
                    controller: replyBady,
                    maxLines: 4,
                    cursorColor: Color(0xFF8793B2),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "الرد على الطلب",
                      fillColor: kBgLightColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      suffixIcon: Container(
                        width: 100,
                        padding: const EdgeInsets.all(0.75), //15
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                           Text(""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.attach_file_rounded)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: Colors.lightGreen,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
  :Center(child: Text("يظهر البلاغ الذي تختاره هنا"),);}
}
