import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/ListOffices.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/component_Home_Page/Browser.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/Reply.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/header.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/profile_Screen.dart';
import 'package:myapp_management_desktop/Service/api/GetReports.dart';
import 'package:myapp_management_desktop/widget/getAttachments.dart';

import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController replyBady = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("ReportScreen");
    var Reportp = Provider.of<ReportScreenData>(context);

    return Reportp.readdata != null
        ? Container(
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
                              hoverColor:
                                  const Color.fromARGB(0, 255, 255, 255),
                              onPressed: () async{
                                await getInfoProfile(Reportp.readdata![Reportp.index].phone!).then((value) =>  showDialog(
                                    context: context,
                                    builder: (BuildContext) => ProfileC( user: value,)));
                               
                              },
                              icon: CircleAvatar(
                                maxRadius: 24,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage("assets/images/avatar.png"),
                                foregroundImage: NetworkImage(
                                    "https://192.168.43.68:7031/SecMobileV01/img/GetProfile?filename=${Reportp.readdata![Reportp.index].phone}.jpg"),
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
                                                    .readdata![Reportp.index]
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          ' إلى > ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        4, 2, 4, 2),
                                                    child: Reportp.readdata![Reportp.index].office! >=
                                                            200
                                                        ? Text(
                                                            maxLines: 1,
                                                            ListOffices.Offices[
                                                                Reportp
                                                                    .readdata![
                                                                        Reportp
                                                                            .index]
                                                                    .office]!,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis)
                                                        : Text(
                                                            maxLines: 1,
                                                            ListOffices.Polices[
                                                                Reportp
                                                                    .readdata![
                                                                        Reportp
                                                                            .index]
                                                                    .office]!,
                                                            style:
                                                                const TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(width: kDefaultPadding / 2),
                                          Text(
                                            Reportp
                                                .readdata![Reportp.index].time,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          Reportp.readdata![Reportp.index]
                                                  .location!.isNotEmpty
                                              ? IconButton(
                                                  tooltip: "عرض الموقع",
                                                  icon:
                                                      Icon(Icons.location_pin),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    print(
                                                        "###################################################################");
                                                    print(
                                                        '${Reportp.readdata![Reportp.index].location}');
                                                    print(
                                                        "###################################################################");
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext) =>
                                                            Browser(
                                                                'https://www.google.com/maps/search/?api=1&query=${Reportp.readdata![Reportp.index].location}'));
                                                  },
                                                )
                                              : Text(""),
                                        ],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Reportp
                                                .readdata![Reportp.index].body,
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
                                              SizedBox(
                                                  width: kDefaultPadding / 4),
                                              ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    kGrayColor,
                                                    BlendMode.srcIn),
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
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Reportp
                                                        .readdata![
                                                            Reportp.index]
                                                        .isAttachmentAvailable ==
                                                    0
                                                ? Text("لايوجد مرفقات")
                                                : new getAttachments(Reportp
                                                    .readdata![Reportp.index]
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
                            hintText: "الرد على البلاغ",
                            fillColor: kBgLightColor,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            suffixIcon: Container(
                              width: 100,
                              padding: const EdgeInsets.all(0.75), //15
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext) => Replys(
                                                replyBody: replyBady,
                                                report: Reportp
                                                    .readdata![Reportp.index]));
                                      },
                                      icon: Icon(Icons.zoom_out_map_outlined)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              Icon(Icons.attach_file_rounded)),
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
        : Center(
            child: Text("يظهر البلاغ الذي تختاره هنا"),
          );
  }
}
