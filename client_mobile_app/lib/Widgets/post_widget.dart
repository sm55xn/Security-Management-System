import 'package:flutter/material.dart';
import 'package:my_security/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_security/view/Home/PageOffice.dart';
import 'package:my_security/Widgets/CardComment.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({required this.post});
  Widget _buildHandle(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.20,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(64, 0, 0, 0),
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(children: [
            IconButton(
              iconSize: 32,
              hoverColor: null,
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return PageOffice(
                  user: post.username,
                );
              })),
              icon: CircleAvatar(
                //  backgroundColor: Colors.amber,
                backgroundImage: AssetImage(post.profileImageUrl),
                radius: 25.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(post.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.verified,
                      color: Colors.blue,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(post.time)
              ],
            ),
          ]),
          SizedBox(height: 20.0),
          Text(post.content, style: TextStyle(fontSize: 15.0)),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.thumbsUp,
                      size: 15.0, color: Colors.blue),
                  Text(' ${post.likes}'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${post.comments} التعليقات '),
                ],
              ),
            ],
          ),
          Divider(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    icon: Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
                    label: Text('إعجاب', style: TextStyle(fontSize: 14.0)),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    icon: Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                    label: Text('تعليق', style: TextStyle(fontSize: 14.0)),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(25),
                            topStart: Radius.circular(25),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: EdgeInsets.only(top: 10),
                          height: size.height * 0.8,
                          child: Column(
                            children: [
                              _buildHandle(context),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(" التعليقات على المنشور",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 24,
                                      ))
                                ],
                              ),
                              const Divider(
                                color: Color.fromARGB(83, 85, 77, 77),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.deepPurple,
                                    child: Text("S"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                    ],
                              ),
                              const Divider(
                                color: Color.fromARGB(83, 85, 77, 77),
                              ),
                              SingleChildScrollView(
                                padding: EdgeInsetsDirectional.only(
                                  start: 20,
                                  end: 20,
                                  bottom: 30,
                                  top: 8,
                                ),
                                child: Wrap(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                          8, (index) => CardComment()),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
