import 'package:image_picker/image_picker.dart';
import 'package:myapp_management_desktop/Providers/ReportScreenData.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/addPhoto.dart';
import 'package:myapp_management_desktop/Service/api/sendPost.dart';
import 'package:myapp_management_desktop/model/user_model.dart';
import 'package:myapp_management_desktop/Screens/componet_update/widgets/profile_avatar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostContainer extends StatefulWidget {
  final User? currentUser;

  const CreatePostContainer({Key? key, this.currentUser})
      : super(key: key);
  @override
  _CreatePostContainerState createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  TextEditingController text = TextEditingController();
  bool isComment = true;
////////////////////////////////////////////addImage////////////////////////////////////
  List<XFile> _images = [];
  final picker = ImagePicker();
  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    List<XFile> pickedFile = await picker.pickMultiImage();

    setState(() {
      if (pickedFile != null) {
        _images.addAll(pickedFile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     var p = Provider.of<ReportScreenData>(context, listen: true);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        //   height: 200,
        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAvatar(
                  imageUrl:p.currentPage !=null? p.currentPage!.Profile!:"",
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    //height: ,
                    child: TextField(
                      controller: text,
                      minLines: 2,
                      maxLines: 20,
                      maxLength: 500,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          hintText: 'اكتب منشورك هنا'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Switch(
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.grey,
                    value: isComment,
                    onChanged: ((value) {
                      setState(() {
                        isComment = value;
                      });
                    })),
                Text("التعليق على المنشور"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: _images.isEmpty ? Text("") : addPhoto(_images),
            ),
            Divider(
              height: 5.0,
              color: Colors.black,
            ),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.videocam_off,
                        color: Colors.red,
                      ),
                      label: Text('فيديو')),
                  VerticalDivider(
                    color: Colors.black87,
                    width: 8.0,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        getImageFromGallery();
                      },
                      icon: Icon(
                        Icons.photo_library,
                        color: Colors.green,
                      ),
                      label: Text('صور')),
                  VerticalDivider(
                    color: Colors.black87,
                    width: 8.0,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        _images.isNotEmpty
                            ? sendPost(
                                _images.first,
                                p.currentPage!.Id,
                                isComment,
                                text.text)
                            : sendPost(null,"db8267d9-a05d-4b27-bcb4-16b966465737",
                                isComment, text.text);
                      },
                      icon: Icon(
                        Icons.send_outlined,
                        color: Colors.cyan,
                      ),
                      label: Text('نشر')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
