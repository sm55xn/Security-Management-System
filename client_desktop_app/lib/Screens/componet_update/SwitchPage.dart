import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/MyPages.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile_avatar.dart';
import 'package:provider/provider.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ReportScreenData>(context, listen: true);

    final List<MyPages> my = p.myPages;
    const _biggerFont = TextStyle(fontSize: 18.0);

    Widget _buildRow(int idx) {
      return ListTile(
        leading: ProfileAvatar(
          imageUrl: my[idx].Profile!,
        ),
        title: Text(
          my[idx].Name,
          style: _biggerFont,
        ),
        onTap: () {
          p.setMyPage(my[idx]);
          Navigator.pop(context);
        },
      );
    }

    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.8,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [

            Container(
              width: size.width * 0.8,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "تغيير الصفحة",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("تم تعيينك للتدوين في الصفحات التالية",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.65,
              child: ListView.builder(
                itemCount: p.myPages.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int i) {
                  return _buildRow(i);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
