import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp_management_desktop/Model/Post.dart';
import 'package:http/http.dart' as http;
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/comment_container.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/post_container.dart';
import 'package:myapp_management_desktop/Service/api/ApiService.dart';
import 'package:myapp_management_desktop/Service/api/GetUpdate.dart';
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  final Post post;

  Comments({Key? key, required this.post}) : super(key: key);
  TextEditingController CommentControler = TextEditingController();
  Future<String?> getKey() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'Key');
    return value;
  }

  String? Keyx;
 
  Future<void> setComment(String text) async {
    print("${post.idPost}");
    print(text);
    if (Keyx == null) {
      Keyx = await getKey();
    }
    var response = await http.post(Uri.parse(ApiService.addComment),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $Keyx'
        },
        body: convert.jsonEncode(
            <String, String>{"idPost": "${post.idPost}", "text": "$text"}));

    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ReportScreenData>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Dialog(
        child: Container(
            width: size.width * 0.5,
            child: Scaffold(
              
              body: CustomScrollView(slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  sliver: SliverToBoxAdapter(child: SizedBox()),
                ),
                SliverToBoxAdapter(
                    child: Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10,
                  ),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PostHeader(
                                post: post,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(post.Text),
                              post.Attchment!.isNotEmpty
                                  ? SizedBox.shrink()
                                  : SizedBox(
                                      height: 6.0,
                                    ),
                            ],
                          ),
                        ),
                        post.Attchment!.isNotEmpty
                            ? Container(
                              height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "https://192.168.43.68:7031/SecMobileV01/img/GetImgUpdate?id=${post.Attchment!}",
                                    fit: BoxFit.cover),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                )),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(
                      child: Center(
                          child: TextButton(
                    onPressed: () async {
                      var C = await GetComments(post.idPost);
                      p.UpdateCommentList(C);
                    },
                    child: Text("التعليقات"),
                  ))),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: p.Comments.length,
                    (context, index) {
                      return CommentContainer(comment: p.Comments[index]);
                    },
                  ),
                ),
               SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 50.0),
                  sliver: SliverToBoxAdapter(
                      child:Center()),
                ),
              ]),
              bottomSheet: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 85,
                  width: double.infinity,
                  child: TextField(
                    controller: CommentControler,
                    maxLines: 4,
                    cursorColor: Color(0xFF8793B2),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "إنقر هنا لإضافة تعليقك",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      suffixIcon: Container(
                        width: 100,
                        padding: const EdgeInsets.all(0.75), //15
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await setComment(CommentControler.text);
                                },
                                icon: Icon(
                                  Icons.send_rounded,
                                  color: Colors.lightGreen,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
