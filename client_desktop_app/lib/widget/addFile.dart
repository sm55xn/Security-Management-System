import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addFile extends StatefulWidget {
  List<PlatformFile>? files;
  addFile(List<PlatformFile>? this.files);

  @override
  _addFileState createState() => _addFileState();
}

class _addFileState extends State<addFile> {
  String getIconFile(String Extension) {
    switch (Extension) {
      case "pdf":
        return 'assets/pdf_icon.png';
      
      default:
        return 'no';
    }
  }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" بايت", "كيلوبايت", "ميجابايت", "جيجابايت", "تيرابايت"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  String Renamefile(String name) {
    if (name.length > 26) {
      String frist = name.substring(1, 13);
      String last = name.substring(name.length - 13);
      return "${frist}..${last}";
    } else
      return name;
  }

  void _clearCachedFiles() async {
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {}
  }

  void _logException(String message) {
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (PlatformFile file in widget.files!)
          Card(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                height: 80,
                width: 320,
                color: Color.fromARGB(94, 192, 5, 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/pdf_icon.png',
                        width: 50,
                        height: 100,
                      ),
                      Container(
                        height: 80,
                        width: 270,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Renamefile(file.name)),
                                Text(getFileSizeString(bytes: file.size)),
                              ],
                            ),
                            IconButton(
                                onPressed: () => {
                                      setState(() {
                                        widget.files!.remove(file);
                                      })
                                    },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          )),
      ],
    );
  }
}
