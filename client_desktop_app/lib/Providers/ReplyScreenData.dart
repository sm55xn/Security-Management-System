import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/Attachment.dart';
import 'package:myapp_management_desktop/Model/Reply.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';

class ReplyScreenData with ChangeNotifier {
  int index = 0;
  List<Reply>? readdata;
  List<Attachment>? attachments;
  updateReply(int i) {
    index = i;
    notifyListeners();
  }

  Future<void> getReplys() async {
    final DatabaseService _databaseService = DatabaseService();
    readdata = await _databaseService.Replys();
    //readdata?.reversed.toList();
  }

  Future<void> getAttachments(String idReport) async {
    final DatabaseService _databaseService = DatabaseService();
    attachments = await _databaseService.attachment(idReport);
  }

  bool update = true;

  void Update(bool up) => update = up;
}
