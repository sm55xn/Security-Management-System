import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_security/models/Attachment.dart';
import 'package:my_security/services/db/db.dart';

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

  Stream<List<Attachment>> getAttachments(String? idReport) async* {
    var attachments = await _databaseService.attachment(idReport!);
    yield attachments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        color: Colors.transparent,
        child: StreamBuilder<List<Attachment>>(
          stream: getAttachments(widget.idReport),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data![index].ext == 'jpg' ||
                        snapshot.data![index].ext == 'png' ||
                        snapshot.data![index].ext == 'webp' ||
                        snapshot.data![index].ext == 'gif') {
                      return Card(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 127,
                          width: 320,
                          child: GestureDetector(
                            onTap: () {
                              _viewImage(context, snapshot.data![index].path);
                            },
                            child: Hero(
                              tag: 'viewImage',
                              child: Image.file(
                                File(snapshot.data![index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ));
                    }
                  });
            } else {
              return const Text("");
            }
          },
        ));
  }

  void _viewImage(BuildContext context, String path) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
              child: Hero(
                tag: 'viewImage',
                child: Image.file(
                  File(path),
                  fit: BoxFit.cover,
                ),
              ),
            ))));
  }
}
