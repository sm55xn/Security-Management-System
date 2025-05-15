import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/commonent_verifcation/VerifiedCard.dart';
import 'package:myapp_management_desktop/Service/api/GetReports.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/ReportCard.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ListOfRequests extends StatefulWidget {
  // Press "Command + ."
  const ListOfRequests({
    Key? key,
  }) : super(key: key);
  @override
  _ListOfRequestsState createState() => _ListOfRequestsState();
}

class _ListOfRequestsState extends State<ListOfRequests> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<List<Report>> getReports() async* {
    final DatabaseService _databaseService = DatabaseService();
    var readdata = await _databaseService.Reports();
    yield readdata;
  }

  Future<void> deleteReport(Report report) async {
    final DatabaseService _databaseService = DatabaseService();
    await _databaseService.insertRemoveReport(report);
    await _databaseService.deleteReport(report.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReports();
  }

  @override
  Widget build(BuildContext context) {
    var Reportp = Provider.of<ReportScreenData>(context, listen: true);
    Reportp.getReports();
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
                  children: [
                    // Once user click the menu icon the menu shows like drawer
                    // Also we want to hide this menu icon on desktop
                  ],
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
                      child: Icon(Icons.list_alt)
                    ),
                    SizedBox(width: 5),
                    Text(
                      "قائمة طلبات التوثيق",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        setState(() {
                          
                        });
                      },
                      child: WebsafeSvg.asset(
                        "assets/Icons/Download.svg",
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
             
              Expanded(
                  child: Align(
                alignment: Alignment.topCenter,
                child: StreamBuilder<List<Report>>(
                  stream: getReports(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        
                        itemBuilder: (context, index) => Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              deleteReport(snapshot.data![index]);
                              snapshot.data!.removeAt(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 36,
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                          ),
                          child: VerifiedCard(
                            isActive: index == Reportp.index,
                            report: snapshot.data![index],
                            press: () {
                              setState(() {
                                Reportp.updateReport(index);
                                print(snapshot.data![index].phone);
                              });
                            },
                          ),
                        ),
                      );
                    } else
                      return Text("لا يوجد بلاغات");
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
