import 'package:flutter/material.dart';

class CardComment extends StatelessWidget {
  const CardComment({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              
              backgroundImage: AssetImage("post.profileImageUrl"),
              radius: 15.0,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("سامح منير",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(110, 0, 0, 0),
                        )),
                     Text(
                      " • ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color.fromARGB(110, 0, 0, 0),
                      ),
                    ),
                    Text(
                      " قبل ساعة واحدة ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color.fromARGB(110, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: size.width * 0.7,
                  child: Text(
                    "هذا النص مثال لما سوف يظهر من تعليق بعد النص مثال لما سوف يظهر من تعليق بعدالنص مثال لما nسوف يظهر من تعليق بعدالنص مثال لما سوف يظهر من تعليق nبعدالنص مثال لما سوف يظهر من تعليق nبعدالنص مثال لما سوف يظهر من تعليقn بعدالنص مثال لما سوف يظهر من تعليق بعدالنصn مثال لما سوف يظهر من تعليق بعداكمال التطبيق",
                    style: TextStyle(
                      fontSize: 11,
                    ),

                  ),
                ),
                const SizedBox(height: 20,)
              ],
            )
          ]),
    );
  }
}
