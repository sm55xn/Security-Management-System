import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/imgAttach.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/images_viewer.dart';

class getAttachments extends StatefulWidget {
  String? idReport;
  getAttachments(
    this.idReport, {
    Key? key,
  }) : super(key: key);

  @override
  _getAttachmentsState createState() => _getAttachmentsState();
}

class _getAttachmentsState extends State<getAttachments> {
  final DatabaseService _databaseService = DatabaseService();
  final StreamController _controller = StreamController();

  // Format File Size
  String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" بايت", "كيلوبايت", "ميجابايت", "جيجابايت", "تيرابايت"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
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

  Stream<List<imgAttach>> getAttachments(String? idReport) async* {
    var attachments = await _databaseService.ImgAttach(idReport!);
    yield attachments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 401,
        color: Colors.transparent,
        child: StreamBuilder<List<imgAttach>>(
          stream: getAttachments(widget.idReport),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Card(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: GestureDetector(
                            onTap: () {
                              int i = index;
                              showDialog(
                                   context: context,
                                   builder: (BuildContext) => imgViewer(
                                       "https://192.168.43.68:7031/SecMobileV01/img/GetImgAttachment?idReport=${snapshot.data![index].idReport}&id=${snapshot.data![index].id}.${snapshot.data![index].ext}"
                                       ));
                            },
                            child: Container(
                              height: 127,
                              width: 320,
                              child: Image.network(
                                "https://192.168.43.68:7031/SecMobileV01/img/GetImgAttachment?idReport=${snapshot.data![index].idReport}&id=${snapshot.data![index].id}.${snapshot.data![index].ext}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))));
            } else
              return Text("لايوجد مرفقات");
          },
        ));
  }
}
