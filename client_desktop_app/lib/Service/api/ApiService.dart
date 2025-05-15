import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static String IP = "https://192.168.43.68";
  static String PORT = ":7031";
  static String SPACE = "/SecManageV01";
  static final String login = "$IP$PORT$SPACE/Accounts/Login";
  static final String Reply = "$IP$PORT$SPACE/Reports/Reply";
  static final String GetReport = "$IP$PORT$SPACE/Reports/GetReports";
  static final String GetPages = "$IP$PORT$SPACE/Updates/GetPage";
  static final String GetMyPages = "$IP$PORT$SPACE/Updates/GetMyPages";
  static final String Delivered = "$IP$PORT$SPACE/Reports/GetReports/Delivered";
  static final String isHandle = "$IP$PORT$SPACE/Reports/GetReports/isHandle";
   static final String GetProfileUser = "$IP$PORT$SPACE/Reports/GetReports/GetProfileUser";
  static final String addAttachmentsForReply =
      "$IP$PORT$SPACE/Reports/Reply/addAttachmentsForReply";
  static final String getAttachment =
      "$IP$PORT$SPACE/Reports/GetReports/GetAttachment";
  static final String addPost = "$IP$PORT$SPACE/Updates/addPost";
  static final String getPost = "$IP$PORT$SPACE/Updates/GetPost";
  static final String getPostsInPage = "$IP$PORT$SPACE/Updates/GetPostsInPage";
  static final String getComments = "$IP$PORT$SPACE/Updates/GetComment";
  static final String addComment = "$IP$PORT$SPACE/Updates/addComment";
  Future<bool> check() async {
    int timeout = 3;
    try {
      var response = await http
          .get(Uri.parse(
              'https://192.168.43.68:7031/SecMobileV01/Auth/Otp/check'))
          .timeout(Duration(seconds: timeout));
      return response.statusCode == 200;
    } on TimeoutException {
      return false;
    }
  }
}
