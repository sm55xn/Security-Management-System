import 'package:myapp_management_desktop/Model/MyPages.dart';
import 'package:myapp_management_desktop/Model/Page.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Service/api/GetUpdate.dart';
import 'package:myapp_management_desktop/Home/update_screen.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    UpdateScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu
  ];

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var p = Provider.of<ReportScreenData>(context, listen: false);
      var pages = await getPages();
    p.UpdatePageList(pages);
    var posts = await GetPost();
    p.UpdatePostList(posts);
    });

   
  }

  

  @override
  Widget build(BuildContext context) {
    MyPages my = new MyPages(Id: "23", Name: "غير محدد", Profile: "re");
    var p = Provider.of<ReportScreenData>(context, listen: true);
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 100.0),
          child: CustomAppBar(
            currentPage: p.currentPage == null ? my : p.currentPage,
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: const SizedBox.shrink(),
      ),
    );
  }
}
