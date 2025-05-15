
import 'package:flutter/material.dart';

class CardAvatar extends StatelessWidget {
  final String user;

  const CardAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         CircleAvatar(
              
              backgroundImage: AssetImage("post.profileImageUrl"),
              radius: 35.0,
            ),
        const SizedBox(
          height: 6.0,
        ),
        Flexible(
          child: Text(
            user,
            style: TextStyle(fontSize: 10.0),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
