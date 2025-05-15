import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Service/api/GetUpdate.dart';
import 'package:myapp_management_desktop/Model/Post.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/Account_list.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/create_post_container.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/more_options_list.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/post_container.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: _HomeDesktopMobile(),
      ),
    );
  }
}

class _HomeDesktopMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var update = Provider.of<ReportScreenData>(context, listen: true);
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: MoreOptionsList(),
            ),
          ),
        ),
        const Spacer(),
        Container(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(child: SizedBox()),
              ),
              SliverToBoxAdapter(
                child: CreatePostContainer(
                  
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                    child: TextButton(
                  child: Text("أخر المستجدات"),
                  onPressed: () async {
                    var posts = await GetPost();
                    update.UpdatePostList(posts);
                  },
                )),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: update.Posts.length,
                  (context, index) {
                    return PostContainer(post: update.Posts[index]);
                  },
                ),
              )
            ],
          ),
          width: 600.0,
        ),
        const Spacer(),
        Flexible(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: AccountList(),
            ),
          ),
        ),
      ],
    );
  }
}
