import 'package:flutter/material.dart';
import 'package:my_security/Widgets/Chips.dart';
import 'package:my_security/models/report.dart';
import 'package:my_security/view/Home/nav_drawer.dart';
import 'package:my_security/view/Home/create_report.dart';
//import 'package:flutter/rendering.dart';
import 'package:my_security/services/db/db.dart';
import 'package:my_security/Widgets/cardReport.dart';

class Reports extends StatefulWidget {
  // Mails({required Key key}) : super(key: key);
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  ScrollController _scrollController = ScrollController();
  static final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Future<List<Reportx>> _getReports() async {
    final DatabaseService _databaseService = DatabaseService();
    return await _databaseService.Reports();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reportx>>(
        future: _getReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
              drawer: const NavDrawer(),
              key: _key,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                title: const Text(
                  'البلاغات',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                actions: <Widget>[
                  Container(
                    width: 65,
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none_outlined,
                        size: 34,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              body: snapshot.data!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                if (index == 0) {
                                  return Chips();
                                }
                                return CardReport(
                                  isAttchment:
                                      snapshot.data![index - 1].isAttachments,
                                  idReport: snapshot.data![index - 1].id!,
                                  arrow: snapshot.data![index - 1].dir,
                                  index: index,
                                  subject: snapshot.data![index - 1].subject,
                                  text: snapshot.data![index - 1].text,
                                  type: snapshot.data![index - 1].type,
                                  time: snapshot.data![index - 1].time,
                                  office: snapshot.data![index - 1].office,
                                  color: Colors.green,
                                );
                              },
                              childCount: snapshot.data!.length + 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/no_data.jpg',
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          " لايوجد بلاغات ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "  يمكنك بإنشاء البلاغات من خلال الضغط على زر الإبلاغ ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => startCompose()));
                },
                label: Text('إبلاغ'),
                icon: Icon(Icons.edit),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                tooltip: 'إبلاغ',
              ));
        });
  }
}
