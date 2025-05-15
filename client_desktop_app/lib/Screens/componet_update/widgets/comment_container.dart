import 'package:myapp_management_desktop/Model/Comment.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CommentContainer extends StatelessWidget {
  final Comment comment;

  const CommentContainer({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:400 ),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[300],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _CommentHeader(
                      comment: comment,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50,),
                        Text(comment.Text),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  final Comment comment;

  const _CommentHeader({Key? key, required this.comment}) : super(key: key);
  bool checkdate(int real, int now) {
    if (now - real <= 2) {
      return true;
    }
    return false;
  }

  bool checkyear(int real, int now) {
    if (now - real == 0) {
      return true;
    }
    return false;
  }

  String date(DateTime t) {
    String m = MonthName(t.month);
    return "${t.day} $m";
  }

  String MonthName(int m) {
    switch (m) {
      case 1:
        return "يناير";
      case 2:
        return "فبراير";
      case 3:
        return "مارس";
      case 4:
        return "أبريل";
      case 5:
        return "مايو";
      case 6:
        return "يونيو";
      case 7:
        return "يوليو";
      case 8:
        return "أغسطس";
      case 9:
        return "سبتمبر";
      case 10:
        return "أكتوبر";
      case 11:
        return "نوفمبر";
      case 12:
        return "ديسمبر";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('y-MM-dd HH:mm:ss');
    DateTime dateTime = formatter.parse(comment.date);
    var now = DateTime.now();
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    return Row(
      children: [
        ProfileAvatar(
          imageUrl: comment.Profile!,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.Name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 3.0,
              ),
              Row(
                children: [
                  checkyear(dateTime.year, now.year)
                      ? Text(
                          checkdate(dateTime.day, now.day)
                              ? timeago.format(dateTime, locale: 'ar')
                              : date(dateTime),
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))
                      : Text(
                          "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.public,
                    size: 12.0,
                    color: Colors.grey[600],
                  ),
                ],
              )
            ],
          ),
        ),
       
      ],
    );
  }
}
