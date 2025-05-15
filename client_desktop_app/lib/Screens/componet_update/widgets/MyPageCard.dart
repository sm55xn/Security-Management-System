import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/MyPages.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile_avatar.dart';

class MyPageCard extends StatelessWidget {
  final MyPages page;

  const MyPageCard({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            "# صفحة ${page.Name}",
            style: TextStyle(fontSize: 24.0,color: Colors.blue,fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        ProfileAvatar(
          imageUrl: page.Profile!,
        ),
        
        
      ],
    );
  }
}
