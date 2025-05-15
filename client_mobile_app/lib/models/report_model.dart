import 'package:my_security/models/user_model.dart';
import 'package:flutter/material.dart';

class Report {
  final Type type;
  final String time;
  final String text;
  final String subject;
  bool isAttchments;
  bool isStarred;
  final bool unread;
  Report({
    required this.type,
    required this.time,
    required this.text,
    required this.subject,
    required this.isStarred,
    required this.unread,
    required this.isAttchments
  });
}

final Type currentUser =
    Type(id: 0, name: 'Deepa Pandey', imageUrl: Colors.red);
final Type linkedln = Type(id: 1, name: 'إدارة الامن', imageUrl: Colors.orange);
final Type sugar = Type(id: 2, name: 'Sugar Cosmetics', imageUrl: Colors.grey);
final Type medium = Type(id: 3, name: 'Medium Daily', imageUrl: Colors.pink);
final Type amazon = Type(id: 4, name: 'Amazon.in', imageUrl: Colors.yellow);
final Type deepak = Type(id: 5, name: 'Deepak Pandey', imageUrl: Colors.red);
final Type balram = Type(id: 6, name: 'Balram Rathore', imageUrl: Colors.teal);
final Type leetcode = Type(id: 7, name: 'LeetCode', imageUrl: Colors.blueGrey);
final Type digitalocean =
 Type(id: 8, name: 'Digital Ocean', imageUrl: Colors.deepPurpleAccent);
