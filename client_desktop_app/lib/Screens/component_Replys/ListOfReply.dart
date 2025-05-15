import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Constants/constants.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Model/Reply.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';
import 'package:myapp_management_desktop/widget/ReplyCard.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:myapp_management_desktop/Service/api/GetReports.dart';

class ListOfReply extends StatefulWidget {
  // Press "Command + ."
  const ListOfReply({
    Key? key,
  }) : super(key: key);
  @override
  _ListOfReplyState createState() => _ListOfReplyState();
}

class _ListOfReplyState extends State<ListOfReply> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Stream<List<Reply>> getReplys() async* {
    final DatabaseService _databaseService = DatabaseService();
    var readdata = await _databaseService.Replys();
    yield readdata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReplys();
  }

  @override
  Widget build(BuildContext context) {
    var Replyp = Provider.of<ReportScreenData>(context, listen: true);
    Replyp.getReplys();
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
                  child: StreamBuilder<List<Reply>>(
                                  stream: getReplys(),
                                  builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        
                        itemBuilder: (context, index) => ReplyCard(
                          isActive: index == Replyp.indexReply,
                          reply: snapshot.data![index],
                          idReport: snapshot.data![index].idReport,
                          press: () {
                            setState(() {
                              Replyp.updateReply(index);
                              
                            });
                          },
                        ),
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
