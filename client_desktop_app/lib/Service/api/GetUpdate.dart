import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myapp_management_desktop/Model/Comment.dart';
import 'package:myapp_management_desktop/Model/MyPages.dart';
import 'package:myapp_management_desktop/Model/Page.dart';
import 'package:myapp_management_desktop/Service/api/ApiService.dart';
import 'dart:convert' as convert;

import 'package:myapp_management_desktop/Model/Post.dart';

Future<String?> getKey() async {
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: 'Key');
  return value;
}

String? Keyx;
Future<List<Page>> getPages() async {
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var ch = await ApiService().check();
  if (ch) {
    var response = await http.get(
      Uri.parse(ApiService.GetPages),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Keyx'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> tmp = convert.jsonDecode(response.body);
      List<Page> pages = [];
      for (var p in tmp) {
        print(p);
        final page = Page.fromMap(p);
        pages.add(page);
      }
      return pages;
      // pagex.UpdatePageList(pages);
    } else {
      //stop
      return [];
    }
  }
  return [];
}

Future<List<MyPages>> GetMyPages() async {
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var response = await http.get(
    Uri.parse(ApiService.GetMyPages),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Keyx'
    },
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    List<dynamic> tmp = convert.jsonDecode(response.body);
    List<MyPages> myPages = [];
    for (var p in tmp) {
      final my = MyPages.fromMap(p);
      myPages.add(my);
    }
    return myPages;
    // Postx.UpdateMyPagesList(myPages);
    // print("${Postx.currentPage.toString()}");
  } else {
    return [];
  }
}

Future<List<Post>> GetPost() async {
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var response = await http.get(
    Uri.parse(ApiService.getPost),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Keyx'
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    List<dynamic> tmp = convert.jsonDecode(response.body);
    List<Post> posts = [];
    for (var p in tmp) {
      final post = Post.fromMap(p);
      posts.add(post);
    }
    return posts;
  } else {
    return [];
  }
}

Future<List<Post>> GetPostsInPage(String idPage) async {
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var response = await http.get(
    Uri.parse(ApiService.getPostsInPage + "?idPage=$idPage"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Keyx'
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    List<dynamic> tmp = convert.jsonDecode(response.body);
    List<Post> posts = [];
    for (var p in tmp) {
      final post = Post.fromMap(p);
      posts.add(post);
    }
    return posts;
  } else {
    //stop
    return [];
  }
}

Future<List<Comment>> GetComments(String idPost) async {
  if (Keyx == null) {
    Keyx = await getKey();
  }
  var response = await http.get(
    Uri.parse(ApiService.getComments + "?idPost=$idPost"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $Keyx'
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    List<dynamic> tmp = convert.jsonDecode(response.body);
    List<Comment> comments = [];
    for (var p in tmp) {
      final post = Comment.fromMap(p);
      comments.add(post);
    }
    return comments;
  } else {
    return [];
  }
}
