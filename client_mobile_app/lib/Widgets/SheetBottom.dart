
import 'package:flutter/material.dart';

class SheetBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
      final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ElevatedButton(
            child: Text('BottomSheet'),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    topStart: Radius.circular(25),
                  ),
                ),
                builder: (context) => SingleChildScrollView(
                  padding: EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                    bottom: 30,
                    top: 8,
                  ),
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          10,
                          (index) => Container(
                            height: 60,
                            margin: EdgeInsetsDirectional.only(bottom: 10),
                            width: double.infinity,
                            color: Colors.yellow,
                            child: Center(
                              child: Text(
                                'Widgets $index',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          10,
                          (index) => Container(
                            height: 60,
                            margin: EdgeInsetsDirectional.only(bottom: 10),
                            width: double.infinity,
                            color: Colors.yellow,
                            child: Center(
                              child: Text(
                                'Widgets $index',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          12,
                          (index) => Container(
                            height: 60,
                            margin: EdgeInsetsDirectional.only(bottom: 10),
                            width: double.infinity,
                            color: Colors.yellow,
                            child: Center(
                              child: Text(
                                'Widgets $index',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}