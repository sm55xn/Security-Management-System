class imgAttach {
  String id;
  String idReport;
  String nameFile;
  String ext;
  imgAttach({
    required this.id,
    required this.idReport,
    required this.nameFile,
    required this.ext,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "idReport": idReport,
        "nameFile": nameFile,
        "ext": ext,
      };
  factory imgAttach.fromMap(Map<String, dynamic> map) {
    return imgAttach(
        id: map["id"],
        idReport: map["idReport"],
        nameFile: map["nameFile"],
        ext: map["ext"]);
  }
  factory imgAttach.fromMapApi(Map<String, dynamic> map) {
    return imgAttach(
        id: map["id"],
        idReport: map["id_Report"],
        nameFile: map["nameFile"],
        ext: map["ext"]);
  }
}
