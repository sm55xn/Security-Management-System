import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static String IP = "https://192.168.43.68";
  static String PORT = ":7031";
  static String SPACE = "/SecMobileV01";
  static final String Url = "$IP$PORT$SPACE/Auth/Otp/login";
  static final String Url2 = '$IP$PORT$SPACE/Auth/Otp/verify';
  static final String addProfile = "$IP$PORT$SPACE/Auth/Profile/addProfile";
  static final String addReport = "$IP$PORT$SPACE/Report/Report/addReport";
  static final String addAttachments ="$IP$PORT$SPACE/Report/Report/addAttachments";
  static final String GetReplyById ="$IP$PORT$SPACE/Report/Report/GetReplyById";
  Future<bool> check() async {
    int timeout = 3;
    try {
      var response = await http
          .get(Uri.parse(
              '$IP$PORT$SPACE/Auth/Otp/check'))
          .timeout(Duration(seconds: timeout));
      return response.statusCode == 200;
    } on TimeoutException {
      return false;
    }
  }
}
