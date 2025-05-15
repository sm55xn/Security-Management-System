import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:websafe_svg/websafe_svg.dart';



class Tags extends StatelessWidget {
  const Tags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            WebsafeSvg.asset("assets/Icons/Angle down.svg", width: 16),
            SizedBox(width: kDefaultPadding / 4),
            WebsafeSvg.asset("assets/Icons/Markup.svg", width: 20),
            SizedBox(width: kDefaultPadding / 2),
            Text(
              "علامات",
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kGrayColor),
            ),
            Spacer(),
           ],
        ),
        SizedBox(height: kDefaultPadding / 2),
        buildTag(context, color: Color(0xFF3A6FF7), title: "مكتب حكومي"),
        buildTag(context, color: Color.fromARGB(255, 247, 58, 58), title: "قسم شرطة"),
        
      ],
    );
  }

  InkWell buildTag(BuildContext context,
      {required Color color, required String title}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(kDefaultPadding * 1.5, 10, 0, 10),
        child: Row(
          children: [
        ColorFiltered(
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                child: WebsafeSvg.asset(
                  "assets/Icons/Markup filled.svg",
                  height: 16,
                ),
              ),
            SizedBox(width: kDefaultPadding / 2),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kGrayColor),
            ),
          ],
        ),
      ),
    );
  }
}
