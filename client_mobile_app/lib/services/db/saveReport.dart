import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_security/models/Attachment.dart';
import 'package:my_security/models/report.dart';
import 'package:my_security/services/db/db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

class saveReport {
  Future<void> onSave(String subjectx, String typex, String textx,
      String officex, List<XFile> images, List<PlatformFile>? files) async {
    final DatabaseService _databaseService = DatabaseService();
    var idReport = Uuid().v4();
    List<XFile> _images = images;
    List<PlatformFile>? _files = files;
    var now = DateTime.now();
    var formatter = DateFormat('y-MM-dd HH:mm:ss');
    final subject = subjectx;
    final type = typex;
    final text = textx;
    final time = formatter.format(now);
    final office = officex;
    final dir = await getApplicationDocumentsDirectory();
    int isAttachments = 0;
    if (_images.isNotEmpty) {
      isAttachments = 1;
      for (XFile img in _images) {
        var id = Uuid().v4();
        var filename = basename(img.path);
        var path = '${dir.path}/$id$filename';
        img.saveTo(path);

        print(
            '###################################################################');
        print('$path');
        await _databaseService.insertAttachment(Attachment(
            id: id,
            idReport: idReport,
            path: path,
            nameFile: filename,
            ext: filename.split('.').last));
      }
    }
    if (_files!.isNotEmpty) {
      isAttachments = 1;
      for (PlatformFile file in _files!) {
        var id = Uuid().v4();

        var path = '${dir.path}/$id${file.name}';
        XFile(file.path!).saveTo(path);

        await _databaseService.insertAttachment(Attachment(
            id: id,
            idReport: idReport,
            path: path,
            nameFile: file.name,
            ext: file.extension!));
      }
    }
    // Add save code here

    await _databaseService.insertReoprt(
      Reportx(
          id: idReport,
          dir: 0,
          text: text,
          type: type,
          idReal: '',
          isAttachments: isAttachments,
          subject: subject,
          time: time,
          office: office),
    );
  }
}
