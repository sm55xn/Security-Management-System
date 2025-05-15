import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:myapp_management_desktop/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class OptionsList extends StatelessWidget {

  final User? currentUser;

  OptionsList({Key? key, this.currentUser}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var choose = Provider.of<ReportScreenData>(context);
    return Container(
      padding: EdgeInsets.all(5),
      color: Color.fromARGB(143, 255, 255, 255),
      
      constraints: BoxConstraints(maxWidth: 250.0),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(3.0),
          //   child: _Option(
          //     icon: MdiIcons.home,
          //     color: Palette.facebookBlue,
          //     label: 'المطلوبين الذي أنشأتهم',
          //     onTap: () => choose.updateWanted(0),
          //     isActive: choose.choiceWanted == 0 ? true : false,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: MdiIcons.postOutline,
              color: Palette.facebookBlue,
              label: 'جميع المطلوبين',
              onTap: () => choose.updateWanted(1),
              isActive: choose.choiceWanted == 1 ? true : false,
            ),
          ),
        Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: Icons.settings,
              color: Palette.facebookBlue,
              label: 'الإعدادات',
              onTap: () {
                choose.updateWanted(2);
              },
              isActive: choose.choiceWanted == 2 ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
class _Option extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  const _Option(
      {Key? key,
      required this.icon,
      required this.color,
      required this.label,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive ? Colors.blue[100] : Colors.transparent),
      child: InkWell(
        onTap:  onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 38.0,
            ),
            const SizedBox(
              width: 6.0,
            ),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
