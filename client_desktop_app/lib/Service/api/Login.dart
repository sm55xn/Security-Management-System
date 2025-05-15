import 'dart:io';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myapp_management_desktop/Service/api/ApiService.dart';
import 'dart:convert' as convert;

Future<int> Login(String Username, String Password) async {
  var response = await http.post(
    Uri.parse(ApiService.login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'Bearer $Key'
    },
    body: convert.jsonEncode(<String, String>{
      'username': "$Username",
      'password': "$Password",
    }),
  );

  if (response.statusCode == 200) {
      final storage = new FlutterSecureStorage();
      var data = convert.jsonDecode(response.body);
      String Key = data['token'];
      await storage.write(key: 'Key', value: Key);
      String? getKey = await storage.read(key: 'Key');
      print(getKey);
  } else if (response.statusCode == 400) {
     print(response.body);
  }

  return response.statusCode;
}
