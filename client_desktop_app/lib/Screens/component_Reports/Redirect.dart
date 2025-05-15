import 'package:flutter/material.dart';
import 'package:myapp_management_desktop/Screens/component_Reports/ListOfOffices.dart';
class Redirect extends StatefulWidget {
  Redirect({Key? key}) : super(key: key);

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
   final ListOffices = TextEditingController();
   final Comment = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
     Size _size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: _size.width * 0.5,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(
              "توجية البلاغ",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        
        body: ListView(
            children: [
             const SizedBox(height: 20.0),
                        const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        child: Text(
                          " قسم الشرطة الذي سيستقبل البلاغ:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        alignment: Alignment.centerRight),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(45, 56, 50, 50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextFormField(
                          //
                          textAlign: TextAlign.start,
                          readOnly: true,
                          controller: ListOffices,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 24,
                              ),
                              hintText: "أختر القسم الذي سيستقبل البلاغ",
                              border: InputBorder.none),

                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext) => ListOfOffices());
                          },
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        child: Text(
                          " درجة خطورة البلاغ:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        alignment: Alignment.centerRight),
                  ),
                  
              RadioListTile(
                value: true,
                groupValue: true,
                title: const Text("منخفضة"),
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
                title: const Text("متوسطة"),
                onChanged: (dynamic value) {},
                secondary: const SizedBox(
                  width: 10,
                ),
              ),
              RadioListTile(
                value: false,
                groupValue: true,
                controlAffinity: ListTileControlAffinity.trailing,
                title: const Text("عالية"),
                onChanged: (dynamic value) {},
                secondary: const SizedBox(
                  width: 10,
                ),),
             // _buildDivider(),
              // ListTile(
              //   title: Text(
              //     "الصلاحيات",
              //     style: itemHeader,
              //   ),
              //   leading: const Icon(Icons.workspace_premium),
              // ),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        child: Text(
                          " إضافة تعليق:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        alignment: Alignment.centerRight),
                  ),
                  
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 85,
                  width: double.infinity,
                  child: TextField(
                    controller: Comment,
                    maxLines: 4,
                    cursorColor: Color(0xFF8793B2),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "إضافة تعليق",
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      suffixIcon: Container(
                        width: 100,
                        padding: const EdgeInsets.all(0.75), //15
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
           
            ],
          ),
         floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                 },
                label: Text('توجية البلاغ'),
                
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                tooltip: 'توجية البلاغ',
              )
        ),

      ),
    );
  
  }
}