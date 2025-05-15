import 'package:flutter/material.dart';
import 'package:my_security/view/Auth/CreateProfile.dart';
import 'package:my_security/Widgets/loading.dart';
import 'package:my_security/Widgets/showDialog.dart';
import 'package:pinput/pinput.dart';

import 'ValidatorFormData.dart';

class MyVerify extends StatefulWidget {
  //const MyVerify(String text, {Key? key}) : super(key: key);
  String phone = '';
  MyVerify(String p) {
    this.phone = p;
  }
  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  String pin = '';

  var ValidText = '';
  void setEnteredOTP(String otp) {}

  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/otp.gif',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "التحقق",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "لقد قمتا بإرسال كود التحقق إلى رقم هاتفك الرجاء ادخال الكود",
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  length: 6,
                  onSubmitted: (String otp) {
                    setEnteredOTP(otp);
                    // يتم استدعاء هذه الدالة عند تقديم الرمز بالكامل
                  },

                  // defaultPinTheme: defaultPinTheme,
                  // focusedPinTheme: focusedPinTheme,
                  // submittedPinTheme: submittedPinTheme,

                  showCursor: true,
                  onCompleted: (pin) => setState(() {
                    this.pin = pin;
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      // احصل على رمز التحقق المدخل من حقل الإدخال
                      if (pin.isEmpty) {
                        ValidText = 'الرجى إدخال كود التححق المرسل الى هاتفك';
                      }
                      DialogBuilder Loading = new DialogBuilder(context);
                      setState(() {
                        Loading.showLoadingIndicator("يتم التحقق من الكود");
                      });

                      bool verificationResult = await OTPVerification.verifyOTP(
                          this.widget.phone, pin);
                      setState(() {
                        Loading.hideOpenDialog();
                      });
                      if (verificationResult) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return MyProfileInformationReg();
                        }));
                      } else {
                        ShowDialog showDialog = new ShowDialog(context);
                        showDialog.show(
                            'فشل في التحقق', 'رمز التحقق الذ أدخلته خاطئ');
                      }
                    },
                    child: const Text("التحقق")),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "تعديل رقم الهاتف؟",
                        style: const TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
