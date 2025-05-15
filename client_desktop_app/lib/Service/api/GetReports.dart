import 'dart:async';
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myapp_management_desktop/Model/Handle.dart';
import 'package:myapp_management_desktop/Model/user_model.dart';
import 'package:myapp_management_desktop/Service/api/ApiService.dart';
import 'dart:convert' as convert;

Future<String?> getKey() async {
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: 'Key');
  return value;
}

String? Keyx;

Future<Handle> isHandle(String idReport) async {
  var response = await http.get(
    Uri.parse(ApiService.isHandle + "?idReport=$idReport"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Keyx'
    },
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    var tmp = convert.jsonDecode(response.body);
    final handle = Handle.fromMap(tmp);
    print(response.body);
    return handle;
  }
  //Failed
  return Handle(isHandle: 4, name: "");
}

Future<User> getInfoProfile(String idUser) async {
  var response = await http.get(
    Uri.parse(ApiService.GetProfileUser + "?idUser=$idUser"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Keyx'
    },
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    var tmp = convert.jsonDecode(response.body);
    final user = User.fromMap(tmp);
    print(response.body);
    return user;
  }
  //Failed
  return User(
      name: "name",
      phone: "phone",
      DateOfBirth: "DateOfBirth",
      gander: "m",
      credibility: 0,
      isIdentity: false,
      replysCount: 0,
      reportsCount: 0,
      reportsFakeCount: 0);
}


// Future<void> getReport() async {
//   var ch = await ApiService().check();
//   if (ch) {
//     var response = await http.get(
//       Uri.parse(
//           ApiService.GetReport + "?idEmp=4ceabe14-69d0-4b71-b0f3-2735c7c1815a"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         //'Authorization': 'Bearer $Key'
//       },
//     );
//     if (response.statusCode == 200) {
//       List<dynamic> tmp = convert.jsonDecode(response.body);
//       for (var r in tmp) {
//         final report = Report.fromMapApi(r);

//         if (report.isAttachmentAvailable == 1) {
//           GetAttachment(report.id);
//         }

//         SaveReport SR = new SaveReport();
//         SR.onSave(report);
//       }
//     } else if (response.statusCode == 400) {
//       //stop
//     }
//   }
// }

// Future<void> GetAttachment(String idReport) async {
//   var response = await http.get(
//     Uri.parse(ApiService.getAttachment + "?idReport=$idReport"),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       //'Authorization': 'Bearer $Key'
//     },
//   );
//   if (response.statusCode == 200) {
//     List<dynamic> tmp = convert.jsonDecode(response.body);
//     for (var a in tmp) {
//       final att = imgAttach.fromMapApi(a);
//       SaveReport SR = new SaveReport();
//       SR.SaveAtt(att);
//     }
//   } else if (response.statusCode == 400) {
//     //stop
//   }
// }

// Future<void> ReviReport(String idReport) async {
//   var response = await http.post(
//     Uri.parse(ApiService.Delivered),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       //'Authorization': 'Bearer $Key'
//     },
//     body: convert.jsonEncode(<String, dynamic>{
//       'idReport': idReport,
//       'type': 0,
//     }),
//   );
//   if (response.statusCode == 200) {
//     //save in database and view
//     //
//   } else if (response.statusCode == 400) {
//     //stop
//   }
// }
