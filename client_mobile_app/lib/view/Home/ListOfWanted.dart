import 'package:flutter/material.dart';
import 'package:my_security/Widgets/WantedCard.dart';
class ListOfWanted extends StatefulWidget {
  const ListOfWanted({Key? key}) : super(key: key);
  

  @override
  State<ListOfWanted> createState() => _ListOfWantedState();
}

class _ListOfWantedState extends State<ListOfWanted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              title: Text("قائمة المطلوبين"),
              elevation: 4,
              shadowColor: Colors.black.withOpacity(.3),
              floating: true,
              backgroundColor: Color(0xffF4F2F7),
              foregroundColor: Colors.black,
              titleTextStyle: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xff3D564D),
                  fontWeight: FontWeight.bold)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16)
                .copyWith(bottom: 40, top: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisExtent: 186,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return WantedCard(
                      personName: "محمد عبدالوهاب",
                      titleOfPost: "جريمة قتل",
                      onClicked: () {
                       
                      });
                },
                childCount: 6,
              ),
            ),
          )
        ],
      ),
    );
  }
}
