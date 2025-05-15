import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp_management_desktop/Model/Attachment.dart';
import 'package:myapp_management_desktop/Model/WantedList.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:uuid/uuid.dart';

class SaveWanted {
  final DatabaseService _databaseService = DatabaseService();
 

  Future<void> onSave(WantedLists wanteds, List<XFile> images) async {
    print(wanteds.id);
     List<XFile> _images = images;
    var now = DateTime.now();
    var formatter = DateFormat('y-MM-dd hh:mm:ss');
    final id = wanteds.id;
    var isAttachment = wanteds.isAttachment; 
    if (_images.isNotEmpty) {
       isAttachment = 1;
      for (XFile img in _images) {
        var ida = Uuid().v4();
        await _databaseService.insertAttachment(Attachment(
            id: ida,
            idReport: id,
            file: File(img.path).readAsBytesSync(),
            nameFile: img.path.split('\\').last,
            ext: img.path.split('.').last));
      }
    }
    final name = wanteds.name;
    final text = wanteds.text;
    final profile = wanteds.profile;

    final time = formatter.format(now as DateTime);
    await _databaseService.insertWantedList(WantedLists(
        id: id,
        profile: profile,
        name: name,
        isAttachment: isAttachment,
        text: text));
  }
}
