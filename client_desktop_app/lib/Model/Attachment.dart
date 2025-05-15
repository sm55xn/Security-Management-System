import 'dart:typed_data';

class Attachment {
  String id;
  String idReport;
  String nameFile;
  Uint8List file;
  String ext;
  Attachment({
    required this.id,
    required this.idReport,
    required this.file,
    required this.nameFile,
    required this.ext,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "idReport": idReport,
        "nameFile": nameFile,
        "file": file,
        "ext": ext,
      };
  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
        id: map["id"],
        idReport: map["idReport"],
        file: map["file"],
        nameFile: map["nameFile"],
        ext: map["ext"]);
   
  }
}
