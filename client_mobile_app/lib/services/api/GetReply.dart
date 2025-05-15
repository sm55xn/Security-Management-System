import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_security/models/report.dart';
import 'package:my_security/services/api/ApiService.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_security/services/db/db.dart';

Future<void> GetReply(String id) async {
  final storage = new FlutterSecureStorage();
    String? Key = await storage.read(key: 'Key');
  var ch = await ApiService().check();
  if (ch) {
    var response = await http.post(
      Uri.parse(ApiService.GetReplyById),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Key'
      },
      body: convert.jsonEncode(<String, dynamic>{'idReply': id}),
    );
    print(response.statusCode);
    if ((response.statusCode) == 200) {
      print(response.body);
      var tmp = convert.jsonDecode(response.body);
      print(response.body);
      final reply = Reportx.fromMapApi(tmp);
      final DatabaseService _databaseService = DatabaseService();
      await _databaseService.insertReoprt(reply);
      
    }
  }
}
