import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Handle.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/Redirect.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/Reply.dart';
import 'package:myapp_management_desktop/Service/api/GetReports.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  Handle handle = Handle(isHandle: 4, name: "");
  getHandle(var Report) async {
    handle = await isHandle(Report.readdata![Report.index].id);
    print(handle.isHandle);
  }
 
  @override
  Widget build(BuildContext context) {
    var Report = Provider.of<ReportScreenData>(context);

    getHandle(Report);
    if (handle.isHandle == 4) {
      Report.UpdateX();
    }
    Size _size = MediaQuery.of(context).size;
    print("${handle.isHandle} RR");
    if (handle.isHandle == 0)
      return Container(
        color: Colors.grey[300],
        margin: EdgeInsets.only(bottom: 10),
        child: Center(
          child: Container(
              width: _size.width * 0.3,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "لم يتم التعامل مع هذا البلاغ بعد.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "هل تريد التعامل مع هذا البلاغ؟",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black),
                    onPressed: () {},
                    child: Text("طلب التعامل مع البلاغ"),
                  )
                ],
              )),
        ),
      );
    else if (handle.isHandle == 1)
      return Container(
        color: Colors.grey[300],
        margin: EdgeInsets.only(bottom: 10),
        child: Center(
          child: Container(
              width: _size.width * 0.3,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "تم التعامل مع هذا البلاغ من قبل ${handle.name}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
        ),
      );
    else if (handle.isHandle == 2)
      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تم تعيينك للتعامل مع هذا البلاغ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[400]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                // We need this back button on mobile only
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      side: BorderSide(color: Colors.green)),
                  label: Text(" رد على البلاغ"),
                  icon: WebsafeSvg.asset(
                    "assets/Icons/Reply.svg",
                    width: 24,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext) =>
                            Replys(report: Report.readdata![Report.index]));
                  },
                ),

                Spacer(),
                // We don't need print option on mobile

                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      side: BorderSide(color: Colors.blue)),
                  label: Text("توجية البلاغ"),
                  icon: WebsafeSvg.asset(
                    "assets/Icons/Reply all.svg",
                    width: 24,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext) => Redirect());
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      side: BorderSide(color: Colors.red)),
                  label: Text("إتخاذ إجراء"),
                  icon: WebsafeSvg.asset(
                    "assets/Icons/More vertical.svg",
                    width: 24,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );
    else
      return Center(child: Text("no data"));
  }
}
