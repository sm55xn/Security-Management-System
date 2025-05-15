import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp_management_desktop/Model/WantedList.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/addPhoto.dart';
import 'package:myapp_management_desktop/Service/db/SaveWanted.dart';
import 'package:uuid/uuid.dart';

class AddWented extends StatefulWidget {
  const AddWented({super.key});

  @override
  State<AddWented> createState() => _AddWentedState();
}

class _AddWentedState extends State<AddWented> {
  final textcontrol = TextEditingController();
  final wantedcontrol = TextEditingController();
  List<XFile> _images = [];
  final picker2 = ImagePicker();
  //Image Picker function to get image from gallery
  Future getImageFromGallery2() async {
    List<XFile> pickedFile = await picker2.pickMultiImage();

    setState(() {
      if (pickedFile != null) {
        _images.addAll(pickedFile);
      }
    });
  }

  final picker = ImagePicker();
  XFile? pickedFile;
  Future getImageFromGallery() async {
    pickedFile = await picker.pickMedia();

    setState(() {
      if (pickedFile != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Dialog(
        child: Scaffold(
      body: Container(
        color: Colors.grey[200],
        width: _size.width,
        height: _size.height,
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 33,
              horizontal: 32,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 32,
            ),
            height: _size.height,
            width: _size.width * 0.30,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(13),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      getImageFromGallery();
                    },
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'إضافة صورة الغلاف ',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 360,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/the_cycle.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: pickedFile != null
                        ? Image.file(
                            File(pickedFile!.path),
                            fit: BoxFit.cover,
                          )
                        : Text(""),
                  ),
                  SizedBox(height: 18),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey[300],
                    child: TextFormField(
                      controller: wantedcontrol,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.person_2),
                        hintText: '  الإسم الكامل للمطلوب',
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 213, 229, 241))),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          getImageFromGallery2();
                        },
                        child: Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent[400],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'إضافة المزيد من الصور ',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 128),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: _images.isEmpty ? Text("") : addPhotoW(_images),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 33,
            ),
            width: _size.width * 0.55,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: textcontrol,
                    cursorHeight: 24,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: "النص",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 18, color: Colors.grey[700]),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                    keyboardType: TextInputType.multiline,
                    minLines: 25,
                    maxLines: 25,
                  ),
                ],
              ),
            )),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          WantedLists wanteds = new WantedLists(
              id: Uuid().v4(),
              profile: File(pickedFile!.path).readAsBytesSync(),
              name: wantedcontrol.text,
              isAttachment: 0,
              text: textcontrol.text);
          SaveWanted save = new SaveWanted();
          save.onSave(wanteds, _images);
        },
        child: Icon(Icons.send),
      ),
    ));
  }
}
