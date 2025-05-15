import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/api/ApiService.dart';

class ValidatorFormDataPhone {
  static final RegExp _phoneNumberRegExp =
      RegExp(r'(^(?:[+0]967(71|78|73|77))?[0-9]{7}$)');
  String typeError = '';

  String isValidPhoneNumber(String input) {
    // يجب أن يبدأ رقم الهاتف بأحد الأرقام المقبولة
    List<String> validPrefixes = ['77', '78', '73', '71'];
    String prefix = '';
    if (input.length >= 2) {
      prefix = input.substring(0, 2);
    }
    if (!validPrefixes.contains(prefix)) {
      typeError = 'يجب أن يبدأ رقم الهاتف بـ 77 أو 78 أو 73 أو 71';
      return typeError;
    }
    // يجب أن يتكون رقم الهاتف من 9 أرقام
    if (input.length != 9) {
      typeError = 'يجب أن يتكون رقم الهاتف من 9 أرقام';
      return typeError;
    }

// يجب أن يكون رقم الهاتف غير محظور
    if (isBannedNumber(input)) {
      typeError = 'هذا الرقم تم حظرة من قبل الإدارة مؤقتاً';
      return typeError;
    }

    // يجب أن لا يكون رقم الهاتف مكررًا
    if (isDuplicateNumber(input)) {
      typeError = 'رقم الهاتف موجود ';
      return typeError;
    }

    return 'رقم الهاتف صحيح';
  }

  static bool isValidPhoneNumber_RegExp(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }
}

// Server الدوال التالية لا يتم كتابتها في هذا المكان وإنما في
// لكن يتم كتابتها للتجربه فقط

bool isBannedNumber(String input) {
  List<String> bannedNumbers = [ '774659071'];
  return bannedNumbers.contains(input);
}

bool isDuplicateNumber(String input) {
  List<String> duplicateNumber = ['711111111', '7333333333'];
  return duplicateNumber.contains(input);
}

// OTP للتحقق من رقم الهاتف من بستخدام التحقق الثنائي(كلمة المرور لمره واحدة فقط )

class OTPVerification {
  static Future<bool> verifyOTP(String phone, String pin) async {
    print('phone is $phone');

    var response = await http.post(
      Uri.parse(ApiService.Url2),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: convert.jsonEncode(<String, String>{'phone': phone, 'pin': pin}),
    );
    print("sss$pin");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final storage = new FlutterSecureStorage();
      var data = convert.jsonDecode(response.body);
      String Key = data['token'];
      await storage.write(key: 'Key', value: Key);
      String? getKey = await storage.read(key: 'Key');
      print(getKey);
      return true;
    } else
      return false;
  }
}
