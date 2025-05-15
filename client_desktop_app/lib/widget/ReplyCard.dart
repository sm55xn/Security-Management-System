import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Reply.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';

import 'package:myapp_management_desktop/widget/extensions.dart';
import 'package:provider/provider.dart';

// ignore: unused_import
import 'package:websafe_svg/websafe_svg.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard(
      {Key? key, this.isActive = false, this.reply, this.press, this.idReport})
      : super(key: key);
  final String? idReport;
  final bool isActive;
  final Reply? reply;
  final VoidCallback? press;
  String? getTitelReport(var p, String id) {
    for (var R in p.readdata) {
      if (R.id == id) return R.subject;
      return "Null";
    }
  }

  @override
  Widget build(BuildContext context) {
    var Replyp = Provider.of<ReportScreenData>(context, listen: true);
    String Tital = getTitelReport(Replyp, idReport!)!;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 3),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 85,
              decoration: BoxDecoration(
                color: isActive ? Colors.blue[100] : kBgDarkColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "الرد على: ",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: isActive ? Colors.red : Colors.red,
                            ),
                            children: [
                              TextSpan(
                                text: "${reply!.toClient} \n",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                      color:
                                          isActive ? Colors.black : kTextColor,
                                    ),
                              ),
                              TextSpan(
                                text: "عنوان البلاغ: ",
                                style: TextStyle(
                                  fontSize: 10,
                                  
                                  fontWeight: FontWeight.w500,
                                  color: isActive ? Colors.red : Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: Tital,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                      color:
                                          isActive ? Colors.black : kTextColor,
                                    ),
                              ),
                            ],
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            reply!.time,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: isActive ? Colors.black : null,
                                    ),
                          ),
                          SizedBox(height: 5),
                          if (reply!.isAttachmentAvailable == 1)
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                isActive ? Colors.black : kGrayColor,
                                BlendMode.srcIn,
                              ),
                              child: WebsafeSvg.asset(
                                "assets/Icons/Paperclip.svg",
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    reply!.body,
                    maxLines: 1,
                   
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.5,
                          color: isActive ? Colors.black : null,
                        ),
                  )
                ],
              ),
            ).addNeumorphism(
              blurRadius: 15,
              borderRadius: 15,
              offset: Offset(5, 5),
              topShadowColor: Colors.white60,
              bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
            ),
          ],
        ),
      ),
    );
  }
}
