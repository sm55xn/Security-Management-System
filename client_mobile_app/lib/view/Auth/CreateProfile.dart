import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_security/Widgets/addProfileImage.dart';
import 'package:my_security/services/api/ApiService.dart';
import 'package:my_security/view/Home/home.dart';
import 'package:my_security/view/User_ProfileData/constant/constantProfile.dart';
import 'package:my_security/view/User_ProfileData/validatorProfileData.dart';
import 'package:my_security/view/User_ProfileData/widgetProfile/TextFormField_Profile.dart';
import 'package:intl/intl.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:http/http.dart' as http;
import 'package:my_security/Widgets/loading.dart';
import 'dart:convert' as convert;
import 'package:my_security/Widgets/showDialog.dart';

class MyProfileInformationReg extends StatefulWidget {
  @override
  State<MyProfileInformationReg> createState() => _MyInformationRegState();
}

class _MyInformationRegState extends State<MyProfileInformationReg> {
 
  @override 
  void initState() {
  
    super.initState();
  }
  TextEditingController dateOfBirth = TextEditingController();
  onTapFun({required BuildContext context}) async {
    var datePicked = await DatePicker.showSimpleDatePicker(context,
       backgroundColor: Color.fromARGB(255, 238, 238, 238),
        initialDate: DateTime(2000),
        firstDate: DateTime(1950),
        lastDate: DateTime(2015),
        dateFormat: "dd-MMMM-yyyy",
        locale: DateTimePickerLocale.ar,
        looping: false,
        reverse: true,
        titleText: "حدد تاريخ ميلادك",
        cancelText: "إلغاء",
        confirmText: "موافق");
    dateOfBirth.text = DateFormat('dd-MM-yyyy').format(datePicked!);
  }

  Future<void> addProfile(String? name, String? gender, String? date) async {
     String? Token;
    DialogBuilder Loading = new DialogBuilder(context);
    setState(() {
      Loading.showLoadingIndicator("يتم الحفظ");
    });
     FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      Token = token;
      print("token is $token");});
    final storage = new FlutterSecureStorage();
    String? Key = await storage.read(key: 'Key');
    var ch = await ApiService().check();
    if (ch) {
    
       var request = http.MultipartRequest(
                "POST", Uri.parse(ApiService.addProfile));
            request.headers['Content-Type'] = 'application/json; charset=UTF-8';
            request.headers['Authorization'] = 'Bearer $Key';
            request.fields['name'] = name!;
            request.fields['Gender'] = gender!;
            request.fields['DateOfBirth'] = date!;
            request.fields['TokenFirebase'] = Token!;
            request.files
                .add(await http.MultipartFile.fromPath('Profile', imageProvider!.path));
            var rep = await request.send();
          
      print(rep.statusCode);
     
      setState(() {
        Loading.hideOpenDialog();
      });
      if ((rep.statusCode) != 200) {
        ShowDialog(context).show('لا يوجد اتصال',
            'يوجد مشكلة ما حيث لم يتمكن التطبيق من الوصول للسيرفر');
      } else if ((rep.statusCode) == 200) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Home();
        }));

        print(name);
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
  
    // TODO: implement reassemble
  }

  @override
  Widget build(BuildContext context) {
    // Dark Mode
    @override
    void dispose() {
      // Dispose text editing controllers
      super.dispose();
    }

    // Scaffold
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 252, 251),
        //leading: IconButton(onPressed: () {}, icon: const Icon(LineA),),
        elevation: 0.0,
        // ignore: prefer_const_constructors
        title: Text(
          'المعلومات الشخصية',
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 7, 7, 7),
          ),
          textAlign: TextAlign.center,
        ),
        //actions: [IconButton(onPressed: (){}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 10),child: addProfileImage(),),
            const Text(
              "المعلومات الشخصية",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "ادخل اسمك الكامل و تاريخ ميلادك و جنسك",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormFieldProfile(
                    hinttext: "الاسم كامل",
                    labeltext: 'الاسم كامل',
                    iconData: Icons.person,

                    mycontroller: fullNameController,
                    sizeText: 30,
                    valid: (value) {
                      final words = value!.split(' ');
                      final validator = ValidatorFormDataName();
                      final validationResult = validator.isValidName(value);

                      if (value.isEmpty || value == " ") {
                        return 'الرجى ادخل الاسم';
                      } else if (words.length <= 2) {
                        return 'الرجى ادخال الاسم كامل';
                      } else if (!validationResult) {
                        return "الرجى ادخال الاسم الصحيح";
                      } else {
                        return null;
                      }
                    },
                    isNumber: false,
                    obscureText: false,
                    onTapIcon: () {},
                    onChange: (p0) {
                      setState(() {
                        fullName = p0;
                      });
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: dateOfBirth,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      labelText: 'تاريخ الميلاد',
                    ),
                    onTap: () => onTapFun(context: context),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      labelText: 'الجنس',
                    ),
                    value: selectedGender,
                    items: const [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('ذكر'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('انثى'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (selectedGender == null) {
                        return 'يرجى اختيار الجنس';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    print(fullName);
                    print(selectedGender);
                    print(dateOfBirth.text);
                    addProfile(fullName, selectedGender, dateOfBirth.text);
                  },
                  child: const Text("حفظ")),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "لمزيد من المعلومات عن سبب طلبنا لهذه المعلومات يرجى مراجعة صفحة اتفاقية الاستخدام",
              style: TextStyle(color: Colors.black54, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
