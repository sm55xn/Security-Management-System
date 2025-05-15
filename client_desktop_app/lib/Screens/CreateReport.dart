import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Attachment.dart';
import 'package:uuid/uuid.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/Widget/addFile.dart';
import 'package:myapp_management_desktop/Widget/addImage.dart';

// import 'dart:io';
class CreateReport extends StatefulWidget {
  CreateReport({
    Key? key,
  }) : super(key: key);

  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  final DatabaseService _databaseService = DatabaseService();
  bool entered = false;
  bool isClicked = false;
  final teTitleController = TextEditingController();
  final teTextController = TextEditingController();
  final nameController = TextEditingController();

  String? selectedValue;
  /////////////////////////////////////upload/////////////////////////////////////////////

  /////////////////////////////////////SaveDataBase///////////////////////////////////////
  Future<void> _onSave() async {
    var idReport = Uuid().v4();
    print(idReport);
    var now = new DateTime.now();
    var formatter = DateFormat('y-MM-dd HH:mm:ss');
    final subject = teTitleController.text;
    final name = nameController.text;
    final text = teTextController.text;
    final time = formatter.format(now);
    if (_images.isNotEmpty) {
      for (XFile img in _images) {
        var id = Uuid().v4();
         widget.key == null
        ?await _databaseService.insertAttachment(
          Attachment(
            id: id,
            idReport: idReport,
            file: File(img.path).readAsBytesSync(),
            nameFile: img.path.split('\\').last,
            ext: img.path.split('.').last))
           : await _databaseService.updateAttachment(
          Attachment(
            id: id,
            idReport: idReport,
            file: File(img.path).readAsBytesSync(),
            nameFile: img.path.split('\\').last,
            ext: img.path.split('.').last));
      }
    }
    // Add save code here
    widget.key == null
        ? await _databaseService.insertReport(
            Report(
              id: idReport,
              office: 22,           
              name: name,
              body: text,
              subject: subject,
              time: time,
              // isChecked: false,
              image: '',
              isAttachmentAvailable: _images.isEmpty ? 0 : 1,
            ),
          )
        : await _databaseService.updateReport(
            Report(
              office: 22,
              id: idReport,
              body: text,
              subject: subject,
              name: "Sameh",
              time: time,
              //  isChecked: false,
              image: '',
              isAttachmentAvailable: _images.isEmpty ? 0 : 1,
            ),
          );
    Navigator.pop(context);
  }
  //////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////addImage////////////////////////////////////
  List<XFile> _images = [];
  final picker = ImagePicker();
  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
     List<XFile>  pickedFile = await picker.pickMultiImage();
    

    setState(() {
      if (pickedFile != null) {
        _images.addAll(pickedFile );
        
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
              'ارسال بلاغ',
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
                    controller: nameController,
                    cursorHeight: 22,
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        hintText: "اسم المرسل",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 78, 73, 73)),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: teTitleController,
                    cursorHeight: 22,
                    style: TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        hintText: "عنوان البلاغ",
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
                    controller: teTextController,
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
                  _images.isNotEmpty? Row(
                    children: [
                      Expanded(child: Divider(color: kBgLightColor,)),
                      Text(" المرفقات" ),
                      Text(" ${_images.length} "),
                      Expanded(child:Divider(color: kBgLightColor))
                    ],
                  ):Divider(),  
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
                onPressed: () {
                  _onSave();
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
