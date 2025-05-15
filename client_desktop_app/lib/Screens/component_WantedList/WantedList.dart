import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Model/WantedList.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/AddWented.dart';
import 'package:myapp_management_desktop/Screens/component_WantedList/ViewWanted.dart';
import 'package:myapp_management_desktop/Service/db/db.dart';

class WantedList extends StatefulWidget {
  WantedList({Key? key}) : super(key: key);

  @override
  State<WantedList> createState() => _WantedListState();
}

class _WantedListState extends State<WantedList> {
  final DatabaseService _databaseService = DatabaseService();
  Stream<List<WantedLists>> getWantedList() async* {
    var wantedList = await _databaseService.WantedList();
    yield wantedList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<List<WantedLists>>(
            stream: getWantedList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    for (var Wanted in snapshot.data!)
                      SizedBox(
                        height: 150,
                        width: 110,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext) => ViewWanted(Wanted.id));
                          },
                          child: Card(
                            semanticContainer: false,
                            clipBehavior: Clip.antiAlias,
                            child: Image.memory(
                              Wanted.profile,
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            // margin: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 150,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlinedButton(
                        onPressed: (() {
                          showDialog(
                              context: context,
                              builder: (BuildContext) =>  AddWented());
                        }),
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            side: BorderSide(color: Colors.blue)),
                        child: Card(
                          color: Colors.transparent,
                          semanticContainer: false,
                          clipBehavior: Clip.antiAlias,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          // margin: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ],
                );
              } else
                return Container(
                  height: 150,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: OutlinedButton(
                    onPressed: (() {
                      showDialog(
                          context: context,
                          builder: (BuildContext) => AddWented());
                    }),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        side: BorderSide(color: Colors.blue)),
                    child: Card(
                      color: Colors.transparent,
                      semanticContainer: false,
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      // margin: EdgeInsets.all(10),
                    ),
                  ),
                );
            }));
  }
}
