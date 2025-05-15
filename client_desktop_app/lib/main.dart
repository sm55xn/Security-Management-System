import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:myapp_management_desktop/Home/login_Screen.dart';
import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Home/main_Screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

// import 'package:myapp_management_desktop/Screens/Report_screen.dart';
String? KEY;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await localNotifier.setup(
    appName: 'myapp_managment_desktop',
    shortcutPolicy: ShortcutPolicy.requireCreate
  );
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;
  KEY = await getKey();
  runApp(ChangeNotifierProvider<ReportScreenData>.value(
    value: ReportScreenData(),
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
        scaffoldBackgroundColor: Palette.scaffold,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: KEY == null ? "Login" : "Home",
      routes: {
        'Home': (context) =>
            Expanded(flex: _size.width > 1340 ? 3 : 4, child: mainScreen(title: 'HOME',)),
        'Login': (context) =>
            Expanded(flex: _size.width > 1340 ? 3 : 4, child: Login()),
      },
    );
  }
}
