import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Model/Report.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/ReportCard.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:http/http.dart' as http;
import 'package:myapp_management_desktop/Model/imgAttach.dart';
import 'package:myapp_management_desktop/Service/api/ApiService.dart';
import 'package:myapp_management_desktop/Service/db/SaveReport.dart';
import 'dart:convert' as convert;

class ListOfReport extends StatefulWidget {
  // Press "Command + ."
  const ListOfReport({
    Key? key,
  }) : super(key: key);
  @override
  _ListOfReportsState createState() => _ListOfReportsState();
}

class _ListOfReportsState extends State<ListOfReport> {
  String? Key;
  Future<String?> getKey() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'Key');
    return value;
  }

  //////////////////////////////API SERVICE////////////////////////////////////
  Future<void> getReport() async {
    if (Key == null) {
      Key = await getKey();
    }
    var ch = await ApiService().check();
    if (ch) {
      var response = await http.get(
        Uri.parse(ApiService.GetReport),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $Key'
        },
      );
      if (response.statusCode == 200) {
        ReportNoti?.show();
        try {
          final player = AudioPlayer();
          await player.play(AssetSource('noti.mp3'));
        } catch (d) {
          print(d);
        }

        List<dynamic> tmp = convert.jsonDecode(response.body);
        for (var r in tmp) {
          final report = Report.fromMapApi(r);
          await Delivered(report.id);
          if (report.isAttachmentAvailable == 1) {
            await GetAttachment(report.id);
          }
          SaveReport SR = new SaveReport();
          SR.onSave(report);
          setState(() {});
        }
      } else if (response.statusCode == 400) {
        //stop
      }
    }
  }

  Future<void> GetAttachment(String idReport) async {
    var response = await http.get(
      Uri.parse(ApiService.getAttachment + "?idReport=$idReport"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Key'
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> tmp = convert.jsonDecode(response.body);
      for (var a in tmp) {
        final att = imgAttach.fromMapApi(a);
        SaveReport SR = new SaveReport();
        SR.SaveAtt(att);
      }
    } else if (response.statusCode == 400) {
      //stop
    }
  }

  Future<void> Delivered(String idReport) async {
    var response = await http.get(
      Uri.parse(ApiService.Delivered + "?idReport=$idReport"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Key'
      },
    );
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {
      //stop
    }
  }

//////////////////////////////////////////////////////////////////////////////////////
  Timer? timer;
//////////////////////////////////////Noti//////////////////////////////////////
  LocalNotification? ReportNoti = LocalNotification(
    identifier: 'ReportNoti',
    title: 'بلاغ جديد ',
    body: 'هل تريد عرض البلاغ الوارد؟',
    actions: [
      LocalNotificationAction(
        text: 'لا',
      ),
      LocalNotificationAction(
        text: 'نعم',
      ),
    ],
  );

  final List<LocalNotification> _notificationList = [];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getReport());
    getReports();
    ReportNoti?.onShow = () {
      if (kDebugMode) {
        print('onShow ${ReportNoti?.identifier}');
      }
    };
    ReportNoti?.onClose = (closeReason) {
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
          // do something
          break;
        case LocalNotificationCloseReason.timedOut:
          // do something
          break;
        default:
      }
      String log = 'onClose ${ReportNoti?.identifier} - $closeReason';
      if (kDebugMode) {
        print(log);
      }
      BotToast.showText(text: log);
    };
    ReportNoti?.onClick = () {
      String log = 'onClick ${ReportNoti?.identifier}';
      if (kDebugMode) {
        print(log);
      }
      BotToast.showText(text: log);
    };
    ReportNoti?.onClickAction = (actionIndex) {
      String log = 'onClickAction ${ReportNoti?.identifier} - $actionIndex';
      if (kDebugMode) {
        print(log);
      }
      BotToast.showText(text: log);
    };
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

//////////////////////////////////////////////////////////////////////////////////////
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
                      onPressed: () async {
                       
                      },
                      child: WebsafeSvg.asset(
                        "assets/Icons/Download.svg",
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
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
                          child: ReportCard(
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
