import 'package:intl/intl.dart';

class Reportx {
  final String? id;
  final String idReal;
  final String type;
  final int dir;
  final String time;
  final String text;
  final String subject;
  final String office;
  final int isAttachments;
  bool? isStarred;
  final bool? unread;
  Reportx({
    this.id,
   required this.idReal,
    required this.type,
    required this.dir,
    required this.time,
    required this.text,
    required this.subject,
    required this.office,
    required this.isAttachments,
    this.isStarred,
    this.unread,
  });

//Chats on Mail Screen
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'subject': subject,
      'type': type,
      'time': time,
      'dir': dir,
      'office': office,
      'idReal': idReal,
      'isAttachments':isAttachments

    };
  }

  factory Reportx.fromMap(Map<String, dynamic> map) {
    return Reportx(
      id: map['id'],
      text: map['text'] ?? '',
      subject: map['subject'] ?? '',
      dir: map['dir'],
      type: map['type'] ?? '',
      time: map['time'] ?? '',
      office: map['office'] ?? '',
      idReal: map['idReal'] ?? '',
      isAttachments:map['isAttachments']??0
    );
  }

  factory Reportx.fromMapApi(Map<String, dynamic> map) {
    var now = DateTime.now();
    var formatter = DateFormat('y-MM-dd HH:mm:ss');
    final time = formatter.format(now);
    return Reportx(
        // id: map['id']?.toInt() ?? 0,
        text: map['text'] ?? '',
        subject: map['title'] ?? '',
        type: map['type'] ?? '',
        time: time,
        office: map['office'] ?? '',
        idReal: map['id'] ?? '',
        isAttachments:map['isAttachments']??0,
        dir: 1);
  }
}
