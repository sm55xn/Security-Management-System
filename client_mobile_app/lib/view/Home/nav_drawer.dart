import 'package:flutter/material.dart';
import 'package:my_security/view/Home/ListOfWanted.dart';
import 'package:my_security/Widgets/cunning.dart';
import 'package:my_security/view/about.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Sameh Hassan'),
      accountEmail: Text('77-039-8407'),
      currentAccountPicture: CircleAvatar(
         backgroundImage: NetworkImage(
                            "https://192.168.43.68:7031/SecMobileV01/img/GetProfile?filename=ca387810-66fc-4c48-8109-73f281401764.jpg"),
                      ),
       
      
    );
    final drawerItems = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 200,
          child: drawerHeader,
        ),
        const Divider(
          color: Color.fromARGB(83, 85, 77, 77),
        ),
        const ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
          selected: true,
          leading: Icon(Icons.mail_outline),
          title: Text('كل البلاغات '),
          
        ),
        const Divider(
          color: Color.fromARGB(83, 85, 77, 77),
        ),
         ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
         
          leading: Icon(Icons.list_outlined),
          title: Text('قائمة المطلوبين'),
          onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ListOfWanted();
                })),
        ),
        const ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
          leading: Icon(Icons.file_copy),
          title: Text('ارشادات الأمان والسلامة'),
        ),
         ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
          leading: Icon(Icons.perm_identity_outlined),
          title: Text('توثيق الحساب'),
          onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Scanner();
                })),
        ),
        const ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
          leading: Icon(Icons.help_outline),
          title: Text('تعليمات'),
        ),
        Divider(
          color: const Color.fromARGB(255, 150, 138, 138),
        ),
        const ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
          leading: Icon(Icons.settings),
          title: Text('الإعدادات'),
        ),
        ListTile(
            selectedColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            selectedTileColor: Color.fromARGB(115, 5, 133, 238),
            leading: Icon(Icons.info),
            title: Text('حول التطبيق'),
            onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return About();
                }))),
        const ListTile(
          selectedColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          selectedTileColor: Color.fromARGB(115, 5, 133, 238),
          leading: Icon(Icons.group),
          title: Text('فريق التطوير'),
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
