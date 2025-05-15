import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Controller/counter_badge.dart';



class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    this.isActive,
    this.isHover = false,
    this.itemCount,
    this.showBorder = true,
    required this.iconSrc,
    required this.title,
    required this.press,

  }) : super(key: key);


  final bool showBorder, isHover;
  final bool? isActive;
  final int? itemCount;
  final IconData? iconSrc;
   final String? title;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                height:40,
               padding: EdgeInsets.only( right: 5),
               decoration: BoxDecoration(
                color: isHover ? Colors.blue[100] : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
                
                child: Row(
                  children: [
                    Icon(
                            iconSrc,
                            size: 20,
                            color: (isActive! || isHover) ? kPrimaryColor : kGrayColor,
                          ),
                    
                    SizedBox(width: kDefaultPadding * 0.75),
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: (isActive! || isHover)
                                ? kTextColor
                                : kGrayColor,
                          ),
                    ),
                    Spacer(),
                    if (itemCount != null) CounterBadge(count: itemCount)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
