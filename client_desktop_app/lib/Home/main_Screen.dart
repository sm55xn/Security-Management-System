import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Home/VerificationScreen.dart';
import 'package:myapp_management_desktop/Home/home_Screen.dart';
import 'package:myapp_management_desktop/Home/nav_screen.dart';
import 'package:myapp_management_desktop/Home/wanted_screen.dart';
import 'package:myapp_management_desktop/Home/login_Screen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                // showTooltip: false,
                displayMode: SideMenuDisplayMode.compact,
                //showHamburger: true,
                hoverColor: Colors.blue,
                selectedHoverColor: Colors.blue,
                selectedColor: Colors.lightBlue,
                selectedTitleTextStyle: const TextStyle(color: Colors.white),
                selectedIconColor: Colors.white,
              ),
              title: Column(
                children: [
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              items: [
                SideMenuItem(
                  title: "صفحة البلاغات",
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.mail),
                  badgeContent: const Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipContent: "صفحة البلاغات",
                ),
                SideMenuItem(
                  title: 'المستجدات',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.newspaper),
                ),
                SideMenuItem(
                  title: 'قائمة المطلوبين',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.location_history_outlined),
                  trailing: Container(
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 3),
                        child: Text(
                          'New',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[800]),
                        ),
                      )),
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const Divider(
                      endIndent: 8,
                      indent: 8,
                    );
                  },
                ),
                SideMenuItem(
                  title: 'طلبات التوثيق',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(
                    Icons.verified,
                    color: Colors.blue,
                  ),
                ),
                SideMenuItem(
                  title: 'Settings',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.settings),
                ),
                SideMenuItem(
                  title: 'Exit',
                  icon: Icon(Icons.exit_to_app),
                  onTap: (index, _) =>
                    Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const Login();}))
                  
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Container(color: Colors.white, child: HomeApp()),
                  Container(color: Colors.white, child: NavScreen()),
                  Container(color: Colors.white, child: WantedScreen()),
                  Container(
                    color: Colors.white,
                    child: const Center(),
                  ),
                  Container(color: Colors.white, child: VerificationScreen()),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Files',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Download',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Only Title',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Only Icon',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              right: 50.0,
            ),
            child: Container(height: 20, color: kBgLightColor)));
  }
}
