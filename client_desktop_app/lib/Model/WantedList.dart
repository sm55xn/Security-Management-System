import 'dart:typed_data';

class WantedLists {
  String id;
  String name;
  Uint8List profile;
  int isAttachment;
  String text;
  WantedLists({
    required this.id,
    required this.profile,
    required this.name,
    required this.isAttachment,
    required this.text,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "isAttachment": isAttachment,
        "name": name,
        "profile": profile,
        "text": text,
      };

  factory WantedLists.fromMap(Map<String, dynamic> map) {
    return WantedLists(
        id: map['id'].toString(),
        profile: map['profile'],
        name: map['name'],
        text: map['text'],
        isAttachment: map['isAttachment']);
  }
}
