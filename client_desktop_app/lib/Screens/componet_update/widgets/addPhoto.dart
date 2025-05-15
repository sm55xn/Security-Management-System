import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addPhoto extends StatefulWidget {
  List<XFile> _image = [];
  addPhoto(this._image);

  @override
  _addPhotoState createState() => _addPhotoState();
}

class _addPhotoState extends State<addPhoto> {
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
          crossAxisCount:widget._image.length==1? widget._image.length:2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
       //   childAspectRatio: widget._image.length / 4,
          children: <Widget>[
            for (XFile imge in widget._image)
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: <Widget>[
                    Container(
                    
                          width: widget._image.length==1?600:320,
                      child: Image.file(
                        File(imge.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          color: Colors.black87,
                            onPressed: () => {
                                  setState(() {
                                    widget._image.remove(imge);
                                  })
                                },
                            icon: Icon(Icons.close,color: Colors.white,))),
                  ],
                ),
              )
          ]),
    );
  }
}
