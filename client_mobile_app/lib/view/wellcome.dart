import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);
  Future<String> _localPath() async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    return "oh";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon:
            Icon((Icons.attachment_rounded), color: Colors.grey[600], size: 34),
        tooltip: "إضافة ملف",
        onPressed: () {},
      ),
    );
  }
}
