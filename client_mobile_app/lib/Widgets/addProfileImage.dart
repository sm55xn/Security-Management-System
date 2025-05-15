import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:my_security/view/User_ProfileData/constant/constantProfile.dart';

class addProfileImage extends StatefulWidget {
  @override
  State<addProfileImage> createState() => _addProfileImageState();
}

class _addProfileImageState extends State<addProfileImage> {
  XFile? image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: image != null
                ? Image.file(File(image!.path), fit: BoxFit.cover)
                : Image.asset('assets/PersonImage.PNG', fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(context)),
              );
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(211, 251, 253, 251),
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "إختيار صورة الملف الشخصي",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        takePhoto(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        'assets/icons/camera.png',
                        width: 64,
                        height: 64,
                      ),
                    ),
                    Text('الكاميرا')
                  ]),
            ),
            const SizedBox(
              width: 40,
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        takePhoto(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        'assets/icons/gallery.png',
                        width: 64,
                        height: 64,
                      ),
                    ),
                    Text('المعرض')
                  ]),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
        imageProvider = image;
      });
      //   API   لحفظ الصورة هنا
      // `pickedImage.path`  استخدم مسار الملف
      // API لتمرير الصورة إلى
    }
  }
}
