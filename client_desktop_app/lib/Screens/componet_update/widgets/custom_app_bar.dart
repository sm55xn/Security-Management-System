import 'package:myapp_management_desktop/Model/MyPages.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/SwitchPage.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/MyPageCard.dart';
import 'package:myapp_management_desktop/Service/api/GetUpdate.dart';
import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final MyPages? currentPage;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar(
      {Key? key,
      this.currentPage,
      required this.icons,
      required this.selectedIndex,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     var p = Provider.of<ReportScreenData>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 4.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'المستجدات',
              style: TextStyle(
                  color: Palette.facebookBlue,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyPageCard(page: currentPage!),
                IconButton(
                  icon: Icon(Icons.more_vert_outlined),
                  onPressed: ()async {
                    var myPages = await GetMyPages();
                    p.UpdateMyPagesList(myPages);
                    showDialog(
                        context: context,
                        builder: (BuildContext) => SwitchPage());
                  },
                ),
                const SizedBox(
                  width: 100.0,
                ),
                CircleButton(
                  iconData: Icons.search,
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 12.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
