import 'package:flutter/material.dart';
//import 'package:my_security/view/Home/reportpage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CardReport extends StatelessWidget {
  const CardReport(
      {super.key,
      required this.idReport,
      required this.isAttchment,
      required this.index,
      required this.subject,
      required this.office,
      required this.text,
      required this.time,
      required this.type,
      required this.arrow,
      required this.color});
  final String idReport;
  final int isAttchment;
  final int arrow;
  final int index;
  final String subject;
  final String office;
  final String type;
  final String time;
  final String text;
  final Color color;
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

  String date(DateTime t) {
    String m = MonthName(t.month);
    return "${t.day} $m";
  }

  @override
  Widget build(BuildContext context) {
    
    print(arrow);
    DateFormat formatter = DateFormat('y-MM-dd HH:mm:ss');
    DateTime dateTime = formatter.parse(time);
    var now = DateTime.now();

    timeago.setLocaleMessages('ar', timeago.ArMessages());

    return Container(
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
       margin: const EdgeInsets.only(top: 3.0, bottom: 3.0, right: 2.0,left: 2.0),
       padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
           
            margin: const EdgeInsets.only(top: 3.0, bottom: 3.0, right: 0.0),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Row(
            
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  radius: 24.0,
                  //_Reports[index - 1].type.imageUrl,
      
                  child: Text(
                    subject[0],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          arrow == 0
                              ? const Icon(Icons.arrow_circle_left_outlined,
                                  color: Colors.green, size: 20)
                              : const Icon(Icons.arrow_circle_right_outlined,
                                  color: Colors.red, size: 20),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.145,
                              child: Text(
                                maxLines: 1,
                                office,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16.0),
                                overflow: TextOverflow.ellipsis,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.05,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                  maxLines: 1,
                                  "مسودة",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 194, 22, 22),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Text(
                                maxLines: 1,
                                subject,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                                overflow: TextOverflow.ellipsis,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          maxLines: 1,
                          text,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               const SizedBox(
                    height: 15.0,
                  ),
                 checkyear(dateTime.year, now.year)
                  ? Text(
                      checkdate(dateTime.day, now.day)
                          ? timeago.format(dateTime, locale: 'ar')
                          : date(dateTime),
                      style: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 10))
                  : Text("${dateTime.day}/${dateTime.month}/${dateTime.year}",
                      style: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
               const SizedBox(
                    height: 30.0,
                  ),
              Container(
                child: Row(
                  children: [
                    Container(child: isAttchment == 1 ? WebsafeSvg.asset(
                                "assets/Icons/Paperclip.svg",colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn),
                              ):const SizedBox(
                      height: 2.0,
                    ),),
                    const SizedBox(
                      width: 10.0,
                    ),           
                    const Icon(
                        Icons.circle,
                        color: Colors.red,size: 15,
                      ),
                  ],
                ),
              ),
                
                
            ],
          )
        ],
      ),
    );
  }
}
