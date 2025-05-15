import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/widget/extensions.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:websafe_svg/websafe_svg.dart';

class VerifiedCard extends StatelessWidget {
  const VerifiedCard({
    Key? key,
    this.isActive = false,
    this.report,
    this.press,
  }) : super(key: key);
  final bool isActive;
  final Report? report;
  final VoidCallback? press;

  bool checkdate(int real, int now) {
    if (now - real <= 2) {
      return true;
    }
    return false;
  }

  bool checkyear(int real, int now) {
    if (now - real == 0) {
      return true;
    }
    return false;
  }

  String date(DateTime t) {
    String m = MonthName(t.month);
    return "${t.day} $m";
  }

  String MonthName(int m) {
    switch (m) {
      case 1:
        return "يناير";
      case 2:
        return "فبراير";
      case 3:
        return "مارس";
      case 4:
        return "أبريل";
      case 5:
        return "مايو";
      case 6:
        return "يونيو";
      case 7:
        return "يوليو";
      case 8:
        return "أغسطس";
      case 9:
        return "سبتمبر";
      case 10:
        return "أكتوبر";
      case 11:
        return "نوفمبر";
      case 12:
        return "ديسمبر";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('y-MM-dd HH:mm:ss');
    DateTime dateTime = formatter.parse(report!.time);
    var now = DateTime.now();

    timeago.setLocaleMessages('ar', timeago.ArMessages());
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
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
                            text: "${report!.name} \n",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isActive ? Colors.black : kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: report!.subject,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color:
                                          isActive ? Colors.black : kTextColor,
                                    ),
                              ),
                            ],
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Column(
                        children: [
                          checkyear(dateTime.year, now.year)
                              ? Text(
                                  checkdate(dateTime.day, now.day)
                                      ? timeago.format(dateTime, locale: 'ar')
                                      : date(dateTime),
                                  style: const TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10))
                              : Text(
                                  "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                                  style: const TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                          SizedBox(height: 5),
                          if (report!.isAttachmentAvailable == 1)
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
                  
                ],
              ),
            ).addNeumorphism(
              blurRadius: 15,
              borderRadius: 15,
              offset: Offset(5, 5),
              topShadowColor: Colors.white60,
              bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
            ),
            if (report!.isChecked == null)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBadgeColor,
                  ),
                ).addNeumorphism(
                  blurRadius: 4,
                  borderRadius: 8,
                  offset: Offset(2, 2),
                ),
              ),
            if (report!.tagColor != null)
              Positioned(
                left: 8,
                top: 0,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    report!.tagColor!,
                    BlendMode.srcIn,
                  ),
                  child: WebsafeSvg.asset(
                    "assets/Icons/Markup filled.svg",
                    height: 18,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
