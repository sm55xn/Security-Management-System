import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Service/api/sendReply.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/Widget/addFile.dart';
import 'package:myapp_management_desktop/Widget/addImage.dart';
import 'package:myapp_management_desktop/widget/loading.dart';
import 'package:myapp_management_desktop/widget/showDialog.dart';

// import 'dart:io';
class Replys extends StatefulWidget {
  Replys({Key? key, TextEditingController? this.replyBody, Report? this.report})
      : super(key: key);
  final replyBody;
  Report? report;

  @override
  _ReplyState createState() => _ReplyState();
}

class _ReplyState extends State<Replys> {
  final DatabaseService _databaseService = DatabaseService();
  bool entered = false;
  bool isClicked = false;
  final teTitleController = TextEditingController();

  String? selectedValue;
  /////////////////////////////////////upload/////////////////////////////////////////////

  /////////////////////////////////////SaveDataBase///////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////addImage////////////////////////////////////
  List<XFile> _images = [];
  final picker = ImagePicker();
  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    List<XFile> pickedFile = await picker.pickMultiImage();

    setState(() {
      if (pickedFile != null) {
        _images.addAll(pickedFile);
      }
    });
  }

////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////addFile//////////////////////////////////
  FilePickerResult? _path;
  List<PlatformFile>? files = [];
  void _pickFiles() async {
    _path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'doc', 'docx', 'mp4', 'ppt'],
    );
    if (_path != null) {
      setState(() {
        files?.addAll(_path!.files);
      });
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    teTitleController.text = "الرد على: ${widget.report!.name}";
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        width: size.width * 0.7,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[100],
            iconTheme: IconThemeData(
              color:
                  Color.fromARGB(255, 161, 107, 107), //change your color here
            ),
            title: Text(
              'الرد على البلاغ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "NeoSansArabic"),
            ),
            actions: [],
            elevation: 0,
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: teTitleController,
                    cursorHeight: 22,
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 78, 73, 73)),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                    keyboardType: TextInputType.text,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black87, width: 0.5),
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: widget.replyBody,
                    cursorHeight: 24,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: "النص",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 18, color: Colors.grey[700]),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: _images.isEmpty ? Text("") : addImage(_images),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: files!.isEmpty ? Text("") : addFile(files),
                  ),
                ],
              ),
            )),
          ]),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  getImageFromGallery();
                },
                icon: Icon((Icons.photo), color: Colors.grey[600], size: 34),
                tooltip: "اضافة صورة",
                iconSize: 34,
              ),
              IconButton(
                onPressed: () {
                  _pickFiles();
                },
                icon: Icon(Icons.attach_file_rounded),
                iconSize: 34,
                tooltip: "اضافة ملفات",
              ),
              FloatingActionButton(
                onPressed: () async {
                  DialogBuilder Loading = new DialogBuilder(context);
                  setState(() {
                    Loading.showLoadingIndicator("يتم إرسال الرد");
                  });
                  print(_images);
                  print(widget.report!.id);
                  print(widget.report!.phone);
                  print(widget.report!.name!);
                  print(widget.replyBody.text);
                 var R =  await SendReply(
                      _images,
                      widget.report!.id,
                      widget.report!.phone,
                      widget.report!.name!,
                      widget.replyBody.text);

                  if (R == 100) {
                    setState(() {
                      Loading.hideOpenDialog();
                    });
                    ShowDialog(context).show('لا يوجد اتصال',
                        'يوجد مشكلة ما حيث لم يتمكن التطبيق من الوصول للسيرفر');
                  } else if (R == 200) {
                    setState(() {
                      Loading.hideOpenDialog();
                    });
                    ShowDialog(context).show('تم ارسال الرد بنجاح', ' ');
                  } else {
                    setState(() {
                      Loading.hideOpenDialog();
                    });
                    ShowDialog(context).show(
                        'لا يوجد اتصال', 'لايمكن الوصل الوصول إلى السيرفر');
                  }
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
