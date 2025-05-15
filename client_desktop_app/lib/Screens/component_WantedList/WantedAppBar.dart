import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/circle_button.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/user_card.dart';
import 'package:flutter/material.dart';


class WantedAppBar extends StatelessWidget {
  

  const WantedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(color: Color.fromARGB(166, 255, 255, 255), boxShadow: const [
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
              'قائمة المطلوبين',
              style: TextStyle(
                  color: Palette.facebookBlue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               // UserCard(user: currentUser),
                const SizedBox(
                  width: 12.0,
                ),
                CircleButton(
                  iconData: Icons.download_for_offline,
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
