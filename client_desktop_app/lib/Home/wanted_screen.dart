
import 'dart:ui';

import 'package:myapp_management_desktop/Screens/component_WantedList/WantedAppBar.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/WantedList.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/options_list.dart';
import 'package:flutter/material.dart';

class WantedScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body:_HomeDesktopMobile(),
       
      ),
    );
  }
}



class _HomeDesktopMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('bengali-patterns-bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
      child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: OptionsList(),
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
             Container(
              child: CustomScrollView(
                slivers: [
                 SliverPadding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                    sliver: SliverToBoxAdapter(
                        child:WantedAppBar()),
                  ),
                 
                 SliverPadding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                    sliver: SliverToBoxAdapter(
                        child: WantedList()),
                  ),
                  
                ],
              ),
              width: _size.width*0.71,
            ),
            
          ],
        ),
      ),
    );
  }
}
