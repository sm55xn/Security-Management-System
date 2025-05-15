import 'package:flutter/material.dart';

class Report {
  final String id;
  final String image, time, body;
  final String? name, subject;
  final String? phone;
  final String? location;
  final int? office;
  final int? isAttachmentAvailable;
  final bool? isChecked;
  final Color? tagColor;

  Report({
    required this.id,
    required this.time,
    this.isChecked,
    required this.image,
    this.phone,
    this.name,
    this.location,
    this.subject,
    required this.body,
    required this.office,
    this.isAttachmentAvailable,
    this.tagColor,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "time": time,
      // "isChecked": isChecked,
      "image": image,
      "location": location,
      //"attachments":attachments,
      "phone": phone,
      "name": name,
      "subject": subject,
      "body": body,
      "office": office,
      "isAttachmentAvailable": isAttachmentAvailable,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
        id: map['id'].toString(),
        time: map['time'].toString(),
        // isChecked: map['isChecked'] ?? false,
        image: map['image'].toString(),
        office: map['office'],
        phone: map['phone'],
        location: map['location'] ?? '',
        name: map['name'],
        subject: map['subject'],
        body: map['body'],
        //  attachments: map['attachments'],
        isAttachmentAvailable: map['isAttachmentAvailable'],
        tagColor: null);
  }
  factory Report.fromMapApi(Map<String, dynamic> map) {
    int att = 0;
    if (map['isAttchments'] == true) {
      att = 1;
    }
    return Report(
        id: map['id'].toString(),
        time: map['date'].toString(),
        // isChecked: map['isChecked'] ?? false,
        image: map['profile'].toString(),
        office: map['office'],
        phone: map['idUser'],
        name: map['name'],
        location: map['location'] ?? '',
        subject: map['title'],
        body: map['text'],
        isAttachmentAvailable: att,
        tagColor: null);
  }
}
