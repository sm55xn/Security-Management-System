import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';

import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/ReplyCard.dart';
import 'package:myapp_management_desktop/widget/ReportCard.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ListOfRemoveReports extends StatefulWidget {
  // Press "Command + ."
  const ListOfRemoveReports({
    Key? key,
  }) : super(key: key);
  @override
  _ListOfRemoveReportsState createState() => _ListOfRemoveReportsState();
}

class _ListOfRemoveReportsState extends State<ListOfRemoveReports> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Stream<List<Report>> getRemoveReports() async* {
    final DatabaseService _databaseService = DatabaseService();
    var readdata = await _databaseService.RemoveReports();
    yield readdata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRemoveReports();
  }

  @override
  Widget build(BuildContext context) {
    var Removep = Provider.of<ReportScreenData>(context, listen: true);
    Removep.getRemoveReports();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgLightColor,
        child: SafeArea(
          right: false,
          child: Column(
            children: [
              // This is our Seearch bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [
                    ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      child: WebsafeSvg.asset(
                        "assets/Icons/Angle down.svg",
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "فرز البلاغات",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    MaterialButton(
                      minWidth: 20,
                      onPressed: () {},
                      child: WebsafeSvg.asset(
                        "assets/Icons/Sort.svg",
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Expanded(
                  child: StreamBuilder<List<Report>>(
                stream: getRemoveReports(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                     
                      itemBuilder: (context, index) => ReportCard(
                        isActive: index == Removep.indexRemove,
                        report: snapshot.data![index],
                        press: () {
                          setState(() {
                            Removep.updateRemoveReport(index);
                          });
                        },
                      ),
                    );
                  } else
                    return Text("er");
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
