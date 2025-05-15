class Reply {
  String id;
  String idReport;
  String time;
  String toClient;
  String body;
  int isAttachmentAvailable;
  Reply({
    required this.id,
    required this.time,
    required this.body,
    required this.idReport,
    required this.toClient,
    required this.isAttachmentAvailable
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "time": time,
     // "isChecked": isChecked
      //"attachments":attachments,
      "idReport":idReport,
      "toClient":toClient,
      "body": body,
      "isAttachmentAvailable": isAttachmentAvailable
    };
  }

  factory Reply.fromMap(Map<String, dynamic> map) {
    return Reply(
        id:map['id'].toString(),
        time: map['time'].toString(),
       // isChecked: map['isChecked'] ?? false,
        idReport: map['idReport'].toString(),
        toClient: map['toClient'],
        
        body: map['body'],
      //  attachments: map['attachments'],
       isAttachmentAvailable: map['isAttachmentAvailable']
    );
    
  }
}

