import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';

import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/component_Replys/view_Report.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/header.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/profile_Screen.dart';
import 'package:myapp_management_desktop/widget/getAttachments.dart';

import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ReplyScreen extends StatelessWidget {
  ReplyScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController replyBady = TextEditingController();
  String? getTitelReport(var p, String id) {
    for (var R in p.readdata) {
      if (R.id == id) return R.subject;
      return "Null";
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ReplyScreen");
    var Reportp = Provider.of<ReportScreenData>(context);
    String Tital = getTitelReport(
        Reportp, Reportp.readdataReplys![Reportp.indexReply].idReport)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: SafeArea(
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  " لقد قمت بالرد على #${Reportp.readdataReplys![Reportp.indexReply].toClient} في البلاغ #$Tital",
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
                        onPressed: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext) => ProfileC());
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
                                            text: "تم الرد على: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    ''' ${Reportp.readdataReplys![Reportp.indexReply].toClient} \n''',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                              TextSpan(
                                                  text: "عنوان البلاغ: ",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  )),
                                              TextSpan(
                                                text: Tital,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            ]),
                                      ),
                                      SizedBox(height: 10,),
                                      OutlinedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext) =>
                                                  viewReport(id: Reportp.readdataReplys![Reportp.indexReply].idReport ));
                                        },
                                         style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),side: BorderSide(color: Colors.green)),
                                        child: Text("استعراض البلاغ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  Reportp
                                      .readdataReplys![Reportp.indexReply].time,
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
                                      Reportp
                                          .readdataReplys![Reportp.indexReply]
                                          .body,
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
                                      child: Reportp
                                                  .readdataReplys![
                                                      Reportp.indexReply]
                                                  .isAttachmentAvailable ==
                                              0
                                          ? Text("لايوجد مرفقات")
                                          : new getAttachments(Reportp
                                              .readdataReplys![
                                                  Reportp.indexReply]
                                              .id),
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
            ],
          ),
        ),
      ),
    );
  }
}
