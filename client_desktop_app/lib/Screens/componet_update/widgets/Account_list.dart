import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile.dart';
import 'package:myapp_management_desktop/Service/api/GetUpdate.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountList extends StatelessWidget {
  const AccountList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ReportScreenData>(context);
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      constraints: BoxConstraints(maxWidth: 280.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "الصفحات الأخرى",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              )),
              IconButton(
                icon: Icon(
                  Icons.update,
                ),
                onPressed: () async {
                  var pages = await getPages();
                  p.UpdatePageList(pages);
                },
              ),
              
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              itemCount: p.Pages.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserCard(
                            page: p.Pages[index],
                          ),
                        )),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext) => Profile(
                                profile: p.Pages[index].Profile!,
                                page: p.Pages[index],
                              ));
                      var posts = await GetPostsInPage(p.Pages[index].Id);
                      p.UpdatePostsInPageList(posts);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
