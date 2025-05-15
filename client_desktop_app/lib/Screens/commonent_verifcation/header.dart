import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HeaderX extends StatelessWidget {
  const HeaderX({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Report = Provider.of<ReportScreenData>(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          // We need this back button on mobile only

         
         
         

          Spacer(),
          // We don't need print option on mobile

          OutlinedButton.icon(
           style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),side: BorderSide(color: Colors.blue)),
           label: Text("توثيق الحساب"),
            icon: Icon(Icons.verified,color: Colors.blue,size: 24,),
            onPressed: () {},
          ),
          SizedBox(width: 10,),
          OutlinedButton.icon(
           style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),side: BorderSide(color: Colors.red)),
           label: Text("إتخاذ إجراء"),
            icon: WebsafeSvg.asset(
              "assets/Icons/More vertical.svg",
              width: 24,
            ),
             onPressed: () {},
          ),
          
        ],
      ),
    );
  }
}
