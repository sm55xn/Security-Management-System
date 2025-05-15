import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:myapp_management_desktop/Model/Attachment.dart';
import 'package:myapp_management_desktop/Model/Reply.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

Future<void> SaveReply(String _id, String name, String _idReport, String _text,
    List<XFile> _images) async {
  final DatabaseService _databaseService = DatabaseService();
  var now = new DateTime.now();
  var formatter = DateFormat('MM-dd');
  final toClient = name;
  final idReport = _idReport;
  final text = _text;
  final time = formatter.format(now);
  final idReply = _id;
  if (_images.isNotEmpty) {
    for (XFile img in _images) {
      var id = Uuid().v4();
      await _databaseService.insertAttachment(Attachment(
          id: id,
          idReport: idReply,
          file: File(img.path).readAsBytesSync(),
          nameFile: img.path.split('\\').last,
          ext: img.path.split('.').last));
    }
  }
  // Add save code here
  await _databaseService.insertReply(Reply(
    id: _id,
    idReport: idReport,
    body: text,
    toClient: toClient!,
    time: time,
    isAttachmentAvailable: _images.isEmpty ? 0 : 1,
  ));
}
