import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_security/services/api/ApiService.dart';
import 'package:my_security/view/Home/home.dart';
import 'package:my_security/Widgets/showDialog.dart';
import 'dart:convert' as convert;
import 'ValidatorFormData.dart';
import 'verify.dart';
import '../../Widgets/loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    countryController.text = "+967";
    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      print("token is $token");
    });
   // NotificationSettings settings = await _firebaseMessaging.requestPermission(alert:true, announcement:false,badge:true,carPlay: false,criticalAlert: false,provisional: false,sound: true );
  }
  
  final formKey = GlobalKey<FormState>();
  var _TypeError = '';
  var SizeNew = 20.00;

  Future<void> login(String phone) async {
    DialogBuilder Loading = new DialogBuilder(context);
    setState(() {
      Loading.showLoadingIndicator("يتم التحقق من رقم الهاتف");
    });
    var ch = await ApiService().check();
    if (ch) {
      var response = await http.post(
        Uri.parse(ApiService.Url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: convert.jsonEncode(<String, dynamic>{
          'phone': phone,
          'pin': '000000',
        }),
      );

      print(response.body);
      setState(() {
        Loading.hideOpenDialog();
      });
      if ((response.statusCode) != 200) {
        ShowDialog(context).show('لا يوجد اتصال',
            'يوجد مشكلة ما حيث لم يتمكن التطبيق من الوصول للسيرفر');
      } else if ((response.statusCode) == 200) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MyVerify(numberController.text);
        }));

        print(phone);
      }
    } else {
      setState(() {
        Loading.hideOpenDialog();
      });
      ShowDialog(context)
          .show('لا يوجد اتصال', 'لايمكن الوصل الوصول إلى السيرفر');
    }
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    final token = FirebaseMessaging.instance.getAPNSToken();
    print("$token");
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img1.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "التحقق من رقم الهاتف",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "ادخل رقم هاتفك لتتمكن من الوصول لجميع الميزات الخاصة بالتطبيق",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 65,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            enabled: false,
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              print(countryController.text);
                              final validator = ValidatorFormDataPhone();
                              final validationResult =
                                  validator.isValidPhoneNumber(value);

                              if (value.isEmpty) {
                                setState(() {
                                  _TypeError = 'الرجى إدخال رقم الهاتف';
                                });
                              } else if (validationResult !=
                                  'رقم الهاتف صحيح') {
                                setState(() {
                                  _TypeError = validationResult;
                                });
                              } else if (!ValidatorFormDataPhone
                                  .isValidPhoneNumber_RegExp(
                                      (countryController.text) + value)) {
                                setState(() {
                                  _TypeError = 'رقم الهاتف غير صحيح';
                                });
                              } else {
                                setState(() {
                                  _TypeError = 'رقم الهاتف صحيح';
                                });
                              }
                            },
                            validator: (value) {
                              final validator = ValidatorFormDataPhone();
                              final validationResult =
                                  validator.isValidPhoneNumber(value!);
                              if (value.isEmpty) {
                                return '';
                              } else if (!ValidatorFormDataPhone
                                  .isValidPhoneNumber_RegExp(
                                      (countryController.text) + value)) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "$_TypeError",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        _TypeError = '';

                        if (formKey.currentState!.validate()) {
                          login(numberController.text);
                        }
                      },
                      child: const Text(
                        "إنضمام",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text(
                    "تخطي",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                ),
                Text("$token")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
