import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_security/view/Auth/CreateProfile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_security/services/api/GetReply.dart';
import 'package:my_security/view/Auth/phone.dart';
import 'view/Home/home.dart';
import 'dart:io';
// Import the generated file
import 'firebase_options.dart';
import 'package:my_security/Provider/ProvideData.dart';

String? KEY;
bool? isProfile;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  HttpOverrides.global = MyHttpOverrides();
  String id = message.data['id'];
  print("the id is $id");
  String type = message.data['type'];
  print("the type is $type");
  if (type == "REPLY") {
    GetReply(id);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  KEY = await getKey();
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider<ProvideData>.value(
    value: ProvideData(),
    child: MyApp(),
  ));
}

Future<String?> getKey() async {
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: 'Key');
  return value;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
      ],
      locale: Locale("ar", "AE"),
      theme: ThemeData(
        fontFamily: 'NeoSansArabic',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
      ),

      initialRoute: KEY == null ? "Login" : "MyProfileInformationReg",
      routes: {
        'MyProfileInformationReg': (context) => MyProfileInformationReg(),
        'Login': (context) => MyPhone(),
      },
    );
  }
}
