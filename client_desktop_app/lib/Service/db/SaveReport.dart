import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp_management_desktop/Model/imgAttach.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/Model/Report.dart';

class SaveReport {
  final DatabaseService _databaseService = DatabaseService();
  List<XFile> _images = [];
  Future<void> onSave(Report r) async {
    var idReport = r.id;
    print(idReport);
    print(r.phone);
    var now = DateTime.now();
    var formatter = DateFormat('MM-dd');
    final subject = r.subject;
    final name = r.name;
    final phone = r.phone;
    final text = r.body;
    final time = r.time;
    final location = r.location;
    final office = r.office;
    final att = r.isAttachmentAvailable;
    //formatter.format(now as DateTime);
    await _databaseService.insertReport(
      Report(
        id: idReport,
        location: location,
        office: office,
        name: name,
        body: text,
        subject: subject,
        time: time,
        phone: phone,
        image: '',
        isAttachmentAvailable: att,
      ),
    );
  }

  Future<void> SaveAtt(imgAttach a) async {
    final id = a.id;
    final idReport = a.idReport;
    final nameFile = a.nameFile;
    final ext = a.ext;

    //formatter.format(now as DateTime);
    await _databaseService.insertImgAttach(
      imgAttach(
        id: id,
        idReport: idReport,
        nameFile: nameFile,
        ext: ext,
      ),
    );
  }
}
