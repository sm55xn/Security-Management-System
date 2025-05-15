// import 'package:flutter/material.dart';
// import 'package:myapp_management_desktop/Constants/constants.dart';
// import 'package:myapp_management_desktop/Controller/Responsive.dart';
// import 'package:websafe_svg/websafe_svg.dart';

// class MyWidget extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//    MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
                
//               padding:
//                     const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                 child: Row(
                  
//                   children: [
//                     // Once user click the menu icon the menu shows like drawer
//                     // Also we want to hide this menu icon on desktop
//                     if (!Responsive.isDesktop(context))
//                       IconButton(
//                         icon: Icon(Icons.menu),
//                         onPressed: () {
//                           _scaffoldKey.currentState!.openDrawer();
//                         },
//                       ),
//                     if (!Responsive.isDesktop(context)) SizedBox(width: 5),
//                     Expanded(
//                       child: TextField(
//                         onChanged: (value) {},
//                         decoration: InputDecoration(
//                           hintText: "Search",
//                           fillColor: kBgLightColor,
//                           filled: true,
//                           suffixIcon: Padding(
//                             padding: const EdgeInsets.all(
//                                 kDefaultPadding * 0.75), //15
//                             child: WebsafeSvg.asset(
//                               "assets/Icons/Search.svg",
//                               width: 20,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//   }
// }