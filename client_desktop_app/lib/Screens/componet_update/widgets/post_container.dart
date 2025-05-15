import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/Comments.dart';
import 'package:myapp_management_desktop/Service/api/GetUpdate.dart';
import 'package:myapp_management_desktop/configs/pallete.dart';
import 'package:myapp_management_desktop/Model/Post.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile_avatar.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostHeader(
                    post: post,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(post.Text),
                  post.Attchment!.isNotEmpty
                      ? SizedBox.shrink()
                      : SizedBox(
                          height: 6.0,
                        ),
                ],
              ),
            ),
            post.Attchment!.isNotEmpty
                ? Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(
                        imageUrl:
                            "https://192.168.43.68:7031/SecMobileV01/img/GetImgUpdate?id=${post.Attchment!}",
                        fit: BoxFit.cover),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: post),
            )
          ],
        ),
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({Key? key, required this.post}) : super(key: key);
  bool checkdate(int real, int now) {
    if (now - real <= 2) {
      return true;
    }
    return false;
  }

  bool checkyear(int real, int now) {
    if (now - real == 0) {
      return true;
    }
    return false;
  }

  String date(DateTime t) {
    String m = MonthName(t.month);
    return "${t.day} $m";
  }

  String MonthName(int m) {
    switch (m) {
      case 1:
        return "يناير";
      case 2:
        return "فبراير";
      case 3:
        return "مارس";
      case 4:
        return "أبريل";
      case 5:
        return "مايو";
      case 6:
        return "يونيو";
      case 7:
        return "يوليو";
      case 8:
        return "أغسطس";
      case 9:
        return "سبتمبر";
      case 10:
        return "أكتوبر";
      case 11:
        return "نوفمبر";
      case 12:
        return "ديسمبر";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('y-MM-dd HH:mm:ss');
    DateTime dateTime = formatter.parse(post.date);
    var now = DateTime.now();
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    return Row(
      children: [
        ProfileAvatar(
          imageUrl: post.Profile!,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.NamePage,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 3.0,
              ),
              Row(
                children: [
                  checkyear(dateTime.year, now.year)
                      ? Text(
                          checkdate(dateTime.day, now.day)
                              ? timeago.format(dateTime, locale: 'ar')
                              : date(dateTime),
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))
                      : Text(
                          "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.public,
                    size: 12.0,
                    color: Colors.grey[600],
                  ),
                ],
              )
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ReportScreenData>(context, listen: true);
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.thumb_up,
                color: Colors.white,
                size: 10.0,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Expanded(
                child: Text(
              '${post.likes}',
              style: TextStyle(color: Colors.grey[600]),
            )),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              '${post.Comments} تعليق',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                size: 20.0,
                color: Colors.grey[600],
              ),
              label: 'إعجاب',
              onTap: () {},
            ),
            post.isComment
                ? InkWell(
                    onTap: () async{
                     var C = await GetComments(post.idPost);
                      p.UpdateCommentList(C);
                     showDialog(
                        context: context,
                        builder: (BuildContext) => Comments(
                              post: post,
                            ));},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      height: 25.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.commentOutline,
                            size: 20.0,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text('تعليق'),
                        ],
                      ),
                    ),
                  )
                : _PostButton(
                    icon: Icon(
                      MdiIcons.commentOffOutline,
                      size: 20.0,
                      color: Colors.grey[600],
                    ),
                    label: 'تعليق',
                    onTap: () {},
                  ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                size: 25.0,
                color: Colors.grey[600],
              ),
              label: 'مشاركة',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(
                  width: 4.0,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
