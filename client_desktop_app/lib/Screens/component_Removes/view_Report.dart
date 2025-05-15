import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/header.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/profile_Screen.dart';
import 'package:myapp_management_desktop/Service/api/GetReports.dart';
import 'package:myapp_management_desktop/widget/getAttachments.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class viewReport extends StatelessWidget {
  const viewReport({Key? key, required String this.id}) : super(key: key);
  final id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var Reportp = Provider.of<ReportScreenData>(context);
    int index = Reportp.readdata!.indexWhere((element) => element.id == id);

    return Dialog(
        child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      width: size.width * 0.7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: SafeArea(
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Header(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Reportp.readdata![index].subject!,
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
                                            text: Reportp.readdata![index].name,
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
                                    Reportp.readdata![index].time,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Reportp.readdata![index].body,
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
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Reportp.readdata![index]
                                                    .isAttachmentAvailable ==
                                                0
                                            ? Text("لايوجد مرفقات")
                                            : new getAttachments(
                                                Reportp.readdata![index].id),
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
      ),
    ));
  }
}
