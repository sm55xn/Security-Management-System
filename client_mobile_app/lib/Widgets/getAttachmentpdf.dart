import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_security/models/Attachment.dart';
import 'package:my_security/services/db/db.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class getAttachmentpdf extends StatefulWidget {
  String? idReport;
  getAttachmentpdf(
    this.idReport, {
    Key? key,
  }) : super(key: key);

  @override
  _getAttachmentpdfState createState() => _getAttachmentpdfState();
}

class _getAttachmentpdfState extends State<getAttachmentpdf> {
  final DatabaseService _databaseService = DatabaseService();
  final StreamController _controller = StreamController();
  final GlobalKey<SfPdfViewerState> _key = GlobalKey();
  // Format File Size
  String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" بايت", "كيلوبايت", "ميجابايت", "جيجابايت", "تيرابايت"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  String getIconFile(String Extension) {
    switch (Extension) {
      case "pdf":
        return 'assets/pdf_icon.png';
      case "mp4":
        return 'assets/vedio_icon.png';
      default:
        return 'no';
    }
  }

  String Renamefile(String name) {
    if (name.length > 25) {
      String frist = name.substring(1, 13);
      String last = name.substring(name.length - 13);
      return "${frist}..${last}";
    } else
      return name;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAttachments(widget.idReport);
  }

  Stream<List<Attachment>> getAttachments(String? idReport) async* {
    var attachments = await _databaseService.attachment(idReport!);
    yield attachments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        color: Colors.grey[200],
        child: StreamBuilder<List<Attachment>>(
            stream: getAttachments(widget.idReport),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    for (Attachment file in snapshot.data!)
                      if (file.ext == 'pdf')
                        Card(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 80,
                            width: 320,
                            color: Color.fromARGB(94, 192, 5, 5),
                            child: GestureDetector(
                              onTap: () {
                                _key.currentState?.openBookmarkView();
                                _viewpdf(
                                    context, '${file.path}');
                              },
                              child: Hero(
                                  tag: 'viewpdf',
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          getIconFile(file.ext!),
                                          width: 50,
                                          height: 100,
                                        ),
                                        Container(
                                          height: 80,
                                          width: 270,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(Renamefile(
                                                      file.nameFile)),
                                                  //   Text(getFileSizeString(bytes: file.)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        )),
                  ],
                );
              } else
                return Text("");
            }));
  }

  void _viewpdf(BuildContext context, String path) {
    print(path);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Scaffold(
            backgroundColor: Colors.grey[200],
            body: Hero(
              tag: 'viewpdf',
              child: SfPdfViewer.file(
                File(path),
                key: _key,
              ),
            ))));
  }
}
