import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile_avatar.dart';
import 'package:myapp_management_desktop/Model/Page.dart' as P;
class UserCard extends StatelessWidget {
  final P.Page page;

  const UserCard({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileAvatar(
          imageUrl: page.Profile!,
        ),
        const SizedBox(
          width: 6.0,
        ),
        Flexible(
          child: Text(
            page.Name,
            style: TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
