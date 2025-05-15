import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp_management_desktop/Home/main_Screen.dart';
import 'package:myapp_management_desktop/Service/api/Login.dart' as L;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();
  late bool _obscureText = true;
  late IconData _icon = Icons.lock_outline;
  late String UserName;
  late String password;

  final UserNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ///final authInstance = context.read<FirebaseAuth>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.05,
                        color: Color.fromARGB(255, 77, 75, 75)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.04),
                    child: Image.asset(
                      'assets/images/nodata.gif',
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ),
                  Text(
                    " مرحبا بكم في إدارة الامن",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.03,
                        color: Color.fromARGB(255, 73, 71, 71)),
                  ),
                  Text(
                    " لحماية كل المواطنين على مستوى المحافظات",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.03,
                        color: Color.fromARGB(255, 73, 71, 71)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  //   gradient: backgroundGradient,
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.height * 0.2,
                    bottom: MediaQuery.of(context).size.height * 0.2),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.05),
                        child: Text(
                          '!(Login) تسجيل دخول ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color.fromARGB(255, 239, 242, 247),
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide *
                                      0.04),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: Text(
                          'ادخل بيانات الحساب بشكل صحيح',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 206, 205, 205),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide *
                                      0.025),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: Colors.grey[300],
                            child: TextFormField(
                              controller: UserNameController,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9\u0600-\u06FF\s]')),
                                LengthLimitingTextInputFormatter(40),
                              ],
                              validator: (value) {
                                final words = value!.split(' ');
                                // ignore: unnecessary_null_comparison
                                if (value == null ||
                                    value.isEmpty ||
                                    value == " ") {
                                  return '   ادخل اسم المستخدم الصحيح';
                                } else if (words.length >= 5) {
                                  return '   لقد وصلت الى الحد الاقصى ';
                                } else {
                                  UserName = value;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.person),
                                hintText: 'اسم المستخدم',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(
                                            255, 197, 221, 240))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.05),
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: Colors.grey[300],
                            child: TextFormField(
                              controller: passwordController,
                              textAlign: TextAlign.right,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == " ") {
                                  return '    ادخل كلمة المرورالصحيح';
                                } else if (value.length < 8) {
                                  return '    كلمة المرور على الاقل 8 احرف';
                                } else {
                                  password = value;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.vpn_key),
                                prefixIcon: IconButton(
                                  icon: Icon(_icon),
                                  onPressed: () {
                                    if (_obscureText) {
                                      _obscureText = false;
                                      _icon = Icons.lock_open;
                                    } else {
                                      _obscureText = true;
                                      _icon = Icons.lock_outline;
                                    }
                                    setState(() {});
                                  },
                                ),
                                hintText: 'كلمة المرور',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(
                                            255, 213, 229, 241))),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9$@#%&*!?\u0600-\u06FF\s]')),
                                    
                                LengthLimitingTextInputFormatter(20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                          //   gradient: const Color.fromARGB(255, 73, 109, 114),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 126, 144, 161)
                                  .withOpacity(0.2),
                              offset: const Offset(0, 5),
                              blurRadius: 6,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FloatingActionButton.extended(
                          heroTag: 'LoginButton',
                          isExtended: true,
                          onPressed: () async{
                            // احصل على رمز التحقق المدخل من حقل الإدخال
                            if (_loginKey.currentState!.validate()) {
                              var R = await L.Login(UserNameController.text,passwordController.text) ;
                              if(R == 200){
                                Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const mainScreen(
                                  title: "HOME",
                                );
                              }));
                              }
                              
                            }
                          },
                          clipBehavior: Clip.antiAlias,
                          label: const Text(
                            'دخول',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 220, 229, 247)),
                          ),
                          backgroundColor: Color.fromARGB(255, 3, 122, 151),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          disabledElevation: 0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/user_1.png'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
