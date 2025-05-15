import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:myapp_management_desktop/Service/api/ApiService.dart';
import 'package:myapp_management_desktop/Service/db/SaveReply.dart';
import 'dart:convert' as convert;
Future<String?> getKey() async {
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: 'Key');
  return value;
}
String? Keyx;
Future<int> SendReply(List<XFile> img, String idReport, String? idUser,
    String name, String text) async {
  final String _idReport = idReport;
  final String _name = name;
  final String? _idUser = idUser;
  final String _text = text;
  List<XFile> _images = img;

  
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var ch = await ApiService().check();
  if (ch) {
    var response = await http.post(
      Uri.parse(ApiService.Reply),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Keyx'
      },
      body: convert.jsonEncode(<String, dynamic>{
        "id_user": "$_idUser",
        "id_Report": "$_idReport",
        "subject": "NoTitle",
        "text": "$_text",
        "isAttchments": _images.isNotEmpty ? true : false,
        "state": 0,
      }),
    );
    print(response.body);
    if ((response.statusCode) != 200) {
      return 100;
    } else if ((response.statusCode) == 200) {
      if (_images.isNotEmpty) {
        for (XFile img in _images) {
          var request = http.MultipartRequest(
              "POST", Uri.parse(ApiService.addAttachmentsForReply));
          request.fields['id_Report'] = response.body;
          request.fields['ext'] = img.path.split(".").last;
          request.fields['nameFile'] = img.path.split("/").last;
          request.files
              .add(await http.MultipartFile.fromPath('file', img.path));
          var rep = await request.send();
        }
        SaveReply(response.body, _name, _idReport, _text, _images);
        return 200;
      }
      return 200;
    }
    return 200;
  } else {
    return 500;
  }
}

Future<void> ReviReport(String idReport) async {
  var response = await http.post(
    Uri.parse(ApiService.Delivered),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'Bearer $Key'
    },
    body: convert.jsonEncode(<String, dynamic>{
      'idReport': idReport,
      'type': 0,
    }),
  );
  if (response.statusCode == 200) {
    //save in database and view
    //
  } else if (response.statusCode == 400) {
    //stop
  }
}
