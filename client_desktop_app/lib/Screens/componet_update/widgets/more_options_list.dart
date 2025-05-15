import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:myapp_management_desktop/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MoreOptionsList extends StatelessWidget {

  final User? currentUser;

  MoreOptionsList({Key? key, this.currentUser}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var choose = Provider.of<ReportScreenData>(context);
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      constraints: BoxConstraints(maxWidth: 280.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: MdiIcons.home,
              color: Palette.facebookBlue,
              label: 'الصفحة الرئيسية',
              onTap: () => choose.updatePosts(0),
              isActive: choose.choicePost == 0 ? true : false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: MdiIcons.postOutline,
              color: Palette.facebookBlue,
              label: 'منشوراتي',
              onTap: () => choose.updatePosts(1),
              isActive: choose.choicePost == 1 ? true : false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: MdiIcons.commentMultiple,
              color: Palette.facebookBlue,
              label: 'التعليقات',
              onTap: () => choose.updatePosts(2),
              isActive: choose.choicePost == 2 ? true : false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: MdiIcons.poll,
              color: Palette.facebookBlue,
              label: 'إستطلاع الرئي',
              onTap: () {
                choose.updatePosts(3);
              },
              isActive: choose.choicePost == 3 ? true : false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: _Option(
              icon: Icons.settings,
              color: Palette.facebookBlue,
              label: 'الإعدادات',
              onTap: () {
                choose.updatePosts(4);
              },
              isActive: choose.choicePost == 4 ? true : false,
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
