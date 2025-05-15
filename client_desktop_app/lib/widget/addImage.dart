import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addImage extends StatefulWidget {
  List<XFile> _image = [];
  addImage(this._image);

  @override
  _addImageState createState() => _addImageState();
}

class _addImageState extends State<addImage> {
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
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.transparent,
      child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 3,
          childAspectRatio: 4 / 3,
          children: <Widget>[
            for (XFile imge in widget._image)
              Card(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 127.8,
                      width: 320,
                      child: Image.file(
                        File(imge.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        height: 80,
                        width: 320,
                        color: Colors.red[100],
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        Renamefile(imge.path.split('\\').last)),
                                    IconButton(
                                        onPressed: () => {
                                              setState(() {
                                                widget._image.remove(imge);
                                              })
                                            },
                                        icon: Icon(Icons.close))
                                  ]),
                              Text(getFileSizeString(
                                  bytes: File(imge.path).lengthSync())),
                            ],
                          ),
                        )),
                  ],
                ),
              ))
          ]),
    );
  }
}
