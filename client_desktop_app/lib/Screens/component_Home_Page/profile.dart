import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var itemHeader = TextStyle(
        color: Colors.grey.shade600,
        fontSize: 16.0,
        fontWeight: FontWeight.bold);
    return Dialog(
      child: Container(
        width: _size.width * 0.5,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(
              "ملفي الشخصي",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: ListView(
            children: [
              const SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      //avatar
                      Ink(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/PersonImage.PNG"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(1.5, 1.5),
                        child: MaterialButton(
                          minWidth: 0,
                          onPressed: () {},
                          textColor: Colors.white,
                          color: Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                          shape: const CircleBorder(),
                          child: const Icon(Icons.camera_alt),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                child: Center(
                    child: Text(
                  "sameh moneer ahmed hassan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              ListTile(
                title: Text(
                  "معلومات الحساب",
                  style: itemHeader,
                ),
                leading: const Icon(Icons.person),
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                title: const Text("private"),
                onChanged: (dynamic value) {},
                secondary: const SizedBox(
                  width: 10,
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                value: false,
                groupValue: true,
                controlAffinity: ListTileControlAffinity.trailing,
                title: const Text("public"),
                onChanged: (dynamic value) {},
                secondary: const SizedBox(
                  width: 10,
                ),
              ),
              _buildDivider(),
              ListTile(
                title: Text(
                  "الصلاحيات",
                  style: itemHeader,
                ),
                leading: const Icon(Icons.workspace_premium),
              ),
              SwitchListTile(
                value: true,
                title: const Text("email notifications"),
                onChanged: (val) {},
                secondary: const SizedBox(
                  width: 10,
                ),
              ),
              SwitchListTile(
                value: true,
                title: const Text("push notifications"),
                onChanged: (value) {},
                secondary: const SizedBox(
                  width: 10,
                ),
              ),
              _buildDivider(),
              const ListTile(
                title: Text("feedback"),
                subtitle: Text("we would love to hear your experience"),
                leading: Icon(Icons.feedback),
              ),
              const ListTile(
                title: Text("terms and conditions"),
                subtitle: Text("legal, terms and conditions"),
                leading: Icon(Icons.file_open_rounded),
              ),
              const ListTile(
                title: Text("logout"),
                subtitle: Text("you can logout from here"),
                leading: Icon(Icons.exit_to_app),
              ),
              AboutListTile(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Divider(
        color: Colors.black,
      ),
    );
  }
}
