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
    if (name.length > 18) {
      String frist = name.substring(1, 9);
      String last = name.substring(name.length - 9);
      return "${frist}..${last}";
    } else
      return name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          ),
          children: <Widget>[
            for (XFile imge in widget._image)
              Card(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 119,
                      width: 320,
                      child: Image.file(
                        File(imge.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        height: 65,
                        width: 320,
                        color: Color.fromARGB(94, 230, 14, 14),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(Renamefile(imge.path.split('/').last),style: TextStyle(fontSize: 12),),
                                    IconButton(
                                      
                                        onPressed: () => {
                                              setState(() {
                                                widget._image.remove(imge);
                                              })
                                            },
                                        icon: Icon(Icons.close,size: 16,))
                                  ]),
                              Text(getFileSizeString(
                                  bytes: File(imge.path).lengthSync()),style: TextStyle(fontSize: 12),),
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
