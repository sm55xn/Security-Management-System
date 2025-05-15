import 'package:flutter/material.dart';

class ShowDialog {
  ShowDialog(this.context);

  final BuildContext context;

  void show(String head, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$head'),
          content: Text('$body'),
          actions: <Widget>[
            TextButton(
              child: const Text('حسنًا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
