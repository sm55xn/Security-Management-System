import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/Attachment.dart';
import 'package:myapp_management_desktop/Model/Comment.dart';
import 'package:myapp_management_desktop/Model/MyPages.dart';
import 'package:myapp_management_desktop/Model/Post.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Model/Reply.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/Model/Page.dart' as P;

class ReportScreenData with ChangeNotifier {
  int choice = 0;
  int choicePost = 0;
  int choiceWanted = 0;
  int index = 0;
  int indexReply = 0;
  List<Report>? readdata;
  List<Reply>? readdataReplys;
  List<Attachment>? attachments;
  List<P.Page> Pages = [];
  MyPages? currentPage;
  List<MyPages> myPages = [];
  List<Post> Posts = [];
  List<Post> PostsInPage = [];
  List<Comment> Comments = [];

  UpdateX() {
    notifyListeners();
  }

  UpdateCommentList(List<Comment> p) {
    Comments = [];
    Comments.addAll(p);
    notifyListeners();
  }

  UpdatePageList(List<P.Page> p) {
    Pages = [];
    Pages.addAll(p);
    notifyListeners();
  }

  setMyPage(MyPages p) {
    currentPage = p;
    notifyListeners();
  }

  UpdateMyPagesList(List<MyPages> p) {
    myPages = [];
    myPages.addAll(p);
    // currentPage = myPages[0];

    notifyListeners();
  }

  UpdatePostList(List<Post> p) {
    Posts = [];
    Posts.addAll(p);
    notifyListeners();
  }

  UpdatePostsInPageList(List<Post> p) {
    PostsInPage = [];
    PostsInPage.addAll(p);
    notifyListeners();
  }

  updateReport(int i) {
    index = i;
    notifyListeners();
  }

  updateReply(int i) {
    indexReply = i;
    notifyListeners();
  }

  Future<void> getReplys() async {
    final DatabaseService _databaseService = DatabaseService();
    readdataReplys = await _databaseService.Replys();
  }

  Future<void> getReports() async {
    final DatabaseService _databaseService = DatabaseService();
    readdata = await _databaseService.Reports();
  }

  Future<void> getAttachments(String idReport) async {
    final DatabaseService _databaseService = DatabaseService();
    attachments = await _databaseService.attachment(idReport);
  }

  bool update = true;

  void Update(bool up) => update = up;

  void updateCh(int ch) {
    choice = ch;
    notifyListeners();
  }

  void updatePosts(int p) {
    choicePost = p;
    notifyListeners();
  }

///////////////////////////////////////////////////
  void updateWanted(int p) {
    choiceWanted = p;
    notifyListeners();
  }

////////////////////////////////////////////////////
  int indexRemove = 0;
  List<Report>? removes;
  updateRemoveReport(int i) {
    index = i;
    notifyListeners();
  }

  Future<void> getRemoveReports() async {
    final DatabaseService _databaseService = DatabaseService();
    readdata = await _databaseService.RemoveReports();
  }
}
