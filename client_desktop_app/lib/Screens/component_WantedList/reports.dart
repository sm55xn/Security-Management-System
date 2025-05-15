import 'package:flutter/material.dart';

import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/CardReport.dart';

class Reports extends StatefulWidget {
  // Mails({required Key key}) : super(key: key);
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  ScrollController _scrollController = ScrollController();
  static final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Future<List<Report>> _getReports() async {
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
    Size _size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: _size.width * 0.35,
        child: FutureBuilder<List<Report>>(
            future: _getReports(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                key: _key,
                body: snapshot.data!.isNotEmpty
                    ? Container(
                        color: Colors.grey[300],
                        // width: _size.height*0.48,
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  if (index == 0) {
                                    return Text("");
                                    
                                  }
                                  return CardReport(
                                    isAttchment: snapshot.data![index - 1]
                                        .isAttachmentAvailable!,
                                    idReport: snapshot.data![index - 1].id,
                                    index: index,
                                    arrow: 1,
                                    subject: snapshot.data![index - 1].subject!,
                                    text: snapshot.data![index - 1].body,
                                    type: "NULL",
                                    time: snapshot.data![index - 1].time,
                                    office: snapshot.data![index - 1].name!,
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
              );
            }),
      ),
    );
  }
}
