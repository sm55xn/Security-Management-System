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
Future<int> sendPost(
    XFile? img, String idPage, bool isComment, String text) async {
  final String _idPage = idPage;
  final bool _isComment = isComment;
  final String _text = text;
  if (img != null) XFile _images = img;
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var ch = await ApiService().check();
  if (ch) {
    var request = http.MultipartRequest("POST", Uri.parse(ApiService.addPost));
    request.headers['Content-Type'] = 'application/json; charset=UTF-8';
    request.headers['Authorization'] = 'Bearer $Keyx';

    request.fields['idPage'] = _idPage;
    request.fields['isComment'] = _isComment.toString();
    request.fields['text'] = _text;
    if (img != null) {
      request.files
          .add(await http.MultipartFile.fromPath('Attchment', img.path));
    }
    var rep = await request.send();
    print(rep.statusCode);
    print(rep.reasonPhrase);
    print(rep.statusCode);
    print(rep.statusCode);
    if ((rep.statusCode) == 200) {
      return 200;
    }
    return rep.statusCode;
  }
  return 100;
}
