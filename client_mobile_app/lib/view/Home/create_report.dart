import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_security/Provider/ProvideData.dart';
import 'package:my_security/Widgets/listPolice.dart';
import 'package:my_security/Widgets/tabs.dart';
import 'package:my_security/models/ListOffices.dart';
import 'package:my_security/services/api/ApiService.dart';
import 'package:my_security/services/db/db.dart';
import 'package:my_security/services/db/saveReport.dart';
import 'package:my_security/view/Home/home.dart';
import 'package:my_security/Widgets/ImageSilderView.dart';
import 'package:my_security/Widgets/addFile.dart';
import 'package:my_security/Widgets/addImage.dart';
import 'package:my_security/Widgets/listOffice.dart';
import 'package:my_security/Widgets/listTypeReports.dart';
import 'package:my_security/Widgets/loading.dart';
import 'package:my_security/Widgets/showDialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

// import 'dart:io';
class Compose extends StatefulWidget {
  const Compose({Key? key, required this.Office, required this.Type})
      : super(key: key);
  final String Office;
  final String Type;

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final DatabaseService _databaseService = DatabaseService();
  bool entered = false;
  bool isClicked = false;
  final teTitleController = TextEditingController();
  final teTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _formValidationMode = AutovalidateMode.onUserInteraction;
  String? Location;
  int? Office;
  String? selectedValue;
  /////////////////////////////////////upload/////////////////////////////////////////////
  Future<int> addReport() async {
    final storage = new FlutterSecureStorage();
    String? Key = await storage.read(key: 'Key');
    bool att = false;
    if (files!.isNotEmpty) {
      att = true;
    }
    if (_images.isNotEmpty) {
      att = true;
    }
    var ch = await ApiService().check();
    if (ch) {
      var response = await http.post(
        Uri.parse(ApiService.addReport),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $Key'
        },
        body: convert.jsonEncode(<String, dynamic>{
          'subject': teTitleController.text,
          'type': 0,
          'text': teTextController.text,
          'isAttchments': att,
          'location': Location,
          'office': Office
        }),
      );

      if ((response.statusCode) != 200) {
        print(response.statusCode);
        print(response.body);
        return 100;
      } else if ((response.statusCode) == 200) {
        if (files!.isNotEmpty) {
          for (PlatformFile file in files!) {
            var request = http.MultipartRequest(
                "POST", Uri.parse(ApiService.addAttachments));
            request.headers['Content-Type'] = 'application/json; charset=UTF-8';
            request.headers['Authorization'] = 'Bearer $Key';
            request.fields['id_Report'] = response.body;
            request.fields['ext'] = file.extension!;
            request.fields['nameFile'] = file.name;
            request.files
                .add(await http.MultipartFile.fromPath('file', file.path!));
            var rep = await request.send();
          }
        }
        if (_images.isNotEmpty) {
          for (XFile img in _images) {
            var request = http.MultipartRequest(
                "POST", Uri.parse(ApiService.addAttachments));
            request.headers['Content-Type'] = 'application/json; charset=UTF-8';
            request.headers['Authorization'] = 'Bearer $Key';

            request.fields['id_Report'] = response.body;
            request.fields['ext'] = img.path.split(".").last;
            request.fields['nameFile'] = img.path.split("/").last;
            request.files
                .add(await http.MultipartFile.fromPath('file', img.path));
            var rep = await request.send();
          }
          return 200;
        }
        return 200;
      }
      return 200;
    } else {
      return 500;
    }
  }

  /////////////////////////////////////SaveDataBase///////////////////////////////////////
  ///////////////////////////////////////////GetLocation///////////////////////////////////////////
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

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

  Future getMediaFromGallery() async {
    List<XFile> pickedFile = await picker.pickMultipleMedia();

    setState(() {
      if (pickedFile != null) {
        _images.addAll(pickedFile);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _images.add(pickedFile);
      }
    });
  }

  Future getVideoFromCamera() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _images.add(pickedFile);
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
      allowedExtensions: ['pdf'],
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
    var PData = Provider.of<ProvideData>(context, listen: true);
    Office = PData.office;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 161, 107, 107), //change your color here
        ),
        title: const Text(
          'إنشاء بلاغ',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: "NeoSansArabic"),
        ),
        actions: [],
        elevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Office! > 200
            ? Container(
                height: 50,
                color: Colors.blue[700],
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سيتم توجية بلاغك إلى ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "# ${ListOffices.Offices[Office]}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400]),
                    ),
                  ],
                )),
              )
            : Container(
                height: 70,
                color: Colors.blue[700],
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سيتم توجية بلاغك إلى ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "# ${ListOffices.Polices[Office]}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[500]),
                    ),
                  ],
                )),
              ),
        Location != null
            ? Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(94, 192, 5, 5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'يحتوي هذا البلاغ على إحداثيات الموقع',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => {
                              setState(() {
                                Location = null;
                              })
                            },
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                        ))
                  ],
                ),
              )
            : Text(""),
        Row(
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                controller: teTitleController,
                cursorHeight: 22,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "عنوان البلاغ",
                    hintStyle: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 78, 73, 73)),
                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                keyboardType: TextInputType.text,
              ),
            )
          ],
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                autovalidateMode: _formValidationMode,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: teTextController,
                      minLines: 1,
                      maxLines: 30,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "قم بكتابة نص البلاغ";
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "نص البلاغ",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xff3D564D),
                          fontFamily: "NeoSansArabic",
                        ),
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: _images.isEmpty ? Text("") : addImage(_images),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: files!.isEmpty ? Text("") : addFile(files),
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ),
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
              showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (ctx) => _buildBottomSheet(ctx));
            },
            icon: Icon(Icons.attach_file_rounded),
            iconSize: 34,
            tooltip: "اضافة ملفات",
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: () async {
              Office = PData.office;
              DialogBuilder Loading = new DialogBuilder(context);
              setState(() {
                Loading.showLoadingIndicator("يتم إرسال البلاغ");
              });
              saveReport SR = new saveReport();
              SR.onSave(teTitleController.text, widget.Type,
                  teTextController.text, widget.Office, _images, files);
              var R = await addReport();
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
                ShowDialog(context)
                    .show('لا يوجد اتصال', 'لايمكن الوصل الوصول إلى السيرفر');
              }
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Home()));
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
      //   bottomSheet: Container(
      //     height: 70,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Container(
      //               child: Row(
      //             children: [
      //               Text("+ المرفقات:", style: TextStyle(fontSize: 16)),
      //               IconButton(
      //                 icon: Icon((Icons.attachment_rounded),
      //                     color: Colors.grey[600], size: 34),
      //                 tooltip: "إضافة ملف",
      //                 onPressed: () {
      //                   //  _pickFiles();
      //                   showModalBottomSheet<void>(
      //                       backgroundColor: Colors.transparent,
      //                       context: context,
      //                       builder: (ctx) => _buildBottomSheet(ctx));
      //                 },
      //               ),
      //               IconButton(
      //                 onPressed: () {
      //                   getImageFromCamera();
      //                 },
      //                 icon: Icon((Icons.camera_alt_sharp),
      //                     color: Colors.grey[600], size: 34),
      //                 tooltip: "الكاميرا",
      //               ),
      //               IconButton(
      //                 onPressed: () {
      //                   getImageFromGallery();
      //                 },
      //                 icon:
      //                     Icon((Icons.photo), color: Colors.grey[600], size: 34),
      //                 tooltip: "اضافة صورة",
      //               )
      //             ],
      //           )),
      //           ElevatedButton(
      //             onPressed: () async {
      //               DialogBuilder Loading = new DialogBuilder(context);
      //               setState(() {
      //                 Loading.showLoadingIndicator("يتم إرسال البلاغ");
      //               });
      //               saveReport SR = new saveReport();
      //               SR.onSave(teTitleController.text, widget.Type,
      //                   teTextController.text, widget.Office, _images, files);
      //               var R = await addReport();
      //               if (R == 100) {
      //                 setState(() {
      //                   Loading.hideOpenDialog();
      //                 });
      //                 ShowDialog(context).show('لا يوجد اتصال',
      //                     'يوجد مشكلة ما حيث لم يتمكن التطبيق من الوصول للسيرفر');
      //               } else if (R == 200) {
      //                 setState(() {
      //                   Loading.hideOpenDialog();
      //                 });
      //                 ShowDialog(context).show('تم ارسال الرد بنجاح', ' ');
      //               } else {
      //                 setState(() {
      //                   Loading.hideOpenDialog();
      //                 });
      //                 ShowDialog(context).show(
      //                     'لا يوجد اتصال', 'لايمكن الوصل الوصول إلى السيرفر');
      //               }
      //               Navigator.push(
      //                   context, MaterialPageRoute(builder: (builder) => Home()));
      //             },
      //             style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.blue.shade600,
      //                 foregroundColor: Colors.white70,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(4))),
      //             child: const Row(
      //               children: [
      //                 Text(
      //                   'إرسال',
      //                   style: TextStyle(
      //                     fontSize: 16,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: 5,
      //                 ),
      //                 Icon(Icons.send_rounded)
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50, left: 15, right: 15),
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        children: <Widget>[
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      getImageFromCamera();
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
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      getMediaFromGallery();
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
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _pickFiles();
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/icons/document.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  Text('المستندات')
                ]),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await _determinePosition().then((value) => setState(() {
                            Location = "${value.latitude},${value.longitude}";
                            Navigator.pop(context);
                          }));
                    },
                    icon: Image.asset(
                      'assets/icons/location.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  Text('الموقع')
                ]),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      getVideoFromCamera();
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/icons/video.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  Text('تسجيل فيديو')
                ]),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

class startCompose extends StatefulWidget {
  startCompose({
    Key? key,
  }) : super(key: key);

  @override
  _startComposeState createState() => _startComposeState();
}

class _startComposeState extends State<startCompose> {
  bool entered = false;
  bool isClicked = false;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _formValidationMode = AutovalidateMode.onUserInteraction;
  final ListOffices = TextEditingController();
  final ListType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var PData = Provider.of<ProvideData>(context, listen: true);
    ListOffices.text = PData.toOffice;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color:
              const Color.fromARGB(255, 161, 107, 107), //change your color here
        ),
        title: const Text(
          'إنشاء بلاغ',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: "NeoSansArabic"),
        ),
        actions: [],
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 200,
            color: Colors.blue,
            child: ImageSilderView(),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Tabs(),
                  const SizedBox(
                    height: 10,
                  ),
                  PData.choice == 1
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                " أختر قسم الشرطة الذي سيتعامل مع البلاغ:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )))
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                " أختر المكتب الذي سيتعامل مع البلاغ:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PData.choice == 1
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(45, 56, 50, 50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: TextFormField(
                                //
                                textAlign: TextAlign.start,
                                readOnly: true,
                                controller: ListOffices,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 24,
                                    ),
                                    hintText: "أختر القسم الذي سيستقبل بلاغك",
                                    border: InputBorder.none),

                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => ListPolice()));
                                },
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(45, 56, 50, 50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                readOnly: true,
                                controller: ListOffices,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      size: 24,
                                    ),
                                    hintText: "أختر المكتب الذي سيستقبل بلاغك",
                                    border: InputBorder.none),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => ListOffice()));
                                },
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        child: Text(
                          'أختر نوع بلاغك:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        alignment: Alignment.centerRight),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(45, 56, 50, 50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                          //
                          textAlign: TextAlign.start,
                          readOnly: true,
                          controller: ListType,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 24,
                              ),
                              hintText: "إختر نوع البلاغ",
                              border: InputBorder.none),

                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext) => listTypeReports());
                          },
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Compose(
                                Office: ListOffices.text,
                                Type: ListType.text,
                              )));
                },
                child: const Text(
                  "كتابة نص البلاغ",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ]),
      ),
    );
  }
}
