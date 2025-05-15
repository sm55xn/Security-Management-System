

class Attachment {
  String? id;
  String idReport;
  String nameFile;
  String path;
  String ext;
  Attachment({
    this.id,
    required this.idReport,
    required this.path,
    required this.nameFile,
    required this.ext,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "idReport": idReport,
        "nameFile": nameFile,
        "path": path,
        "ext": ext,
      };
  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
        id: map["id"],
        idReport: map["idReport"],
        path: map["path"],
        nameFile: map["nameFile"],
        ext: map["ext"]);
  }
}
