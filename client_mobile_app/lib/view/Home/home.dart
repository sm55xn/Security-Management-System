import 'package:flutter/material.dart';
import 'package:my_security/view/Home/reports.dart';
import 'package:my_security/view/Home/updates.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  //const FrontPage({required Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [ Reports(), Updates()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
              child: Stack(
                children: <Widget>[
                   const Icon(
                    Icons.mail,
                    size: 35,
                  ),
                   Positioned(
                    right: 0,
                    top: 0.0,
                    child:  Container(
                      padding: EdgeInsets.all(1),
                      decoration:  BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child:  const Text(
                        '9+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            label: 'بلاغات',
          ),
           const BottomNavigationBarItem(
            icon: Icon(Icons.newspaper, size: 35.0),
            label: 'مستجدات',
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

