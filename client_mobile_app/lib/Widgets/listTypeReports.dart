import 'package:flutter/material.dart';
import 'package:my_security/view/Home/create_report.dart';

class listTypeReports extends StatelessWidget {
  const listTypeReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const numItems = 19;
    final List<String> items = [
      'قسـم الشرطة',
      'مكتب البحث الجنائي',
      'مكتب المحامة العامة',
      'مكتب الصحه',
      'مكتب النظافة',
      'مكتب البلدية',
      'مكتب الضرائب',
      'مكتب العقارات',
      'مكتب الاحول المدينة',
      'مكتب الجوازات',
      'مكتب الهجرة',
      'مكتب الشؤن الإجتماعية',
      'مكتب المرور',
      'مكتب حالة الطوارئ',
      'مكتب الدفاع المدني',
      'مكتب التنمية الإقتصادية',
      'مكتب السياحة والثقافة',
      'مكتب العمل والتوظيف',
      'مكتب حماية المستهلك',
      'مكتب البحوث والتطوير',
    ];
    const _biggerFont = TextStyle(fontSize: 18.0);

    Widget _buildRow(int idx) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('${idx + 1}'),
        ),
        title: Text(
          items[idx],
          style: _biggerFont,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => startCompose(
                       
                      )));
         // Navigator.pop(context);
        },
      );
    }

    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.8,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Container(
              width: size.width * 0.8,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "إختر نوع البلاغ",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.72,
              child: ListView.builder(
                itemCount: numItems * 2 + 2,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int i) {
                  if (i.isOdd)
                    return const Divider(
                      color: Color.fromARGB(83, 85, 77, 77),
                    );
                  final index = i ~/ 2;
                  return _buildRow(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
