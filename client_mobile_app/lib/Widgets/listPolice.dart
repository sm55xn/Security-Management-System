import 'package:flutter/material.dart';
import 'package:my_security/Provider/ProvideData.dart';
import 'package:my_security/view/Home/create_report.dart';
import 'package:provider/provider.dart';

class ListPolice extends StatelessWidget {
  const ListPolice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var PData = Provider.of<ProvideData>(context, listen: true);
    const numItems = 19;
    final Map<int, String> items = {
      101: "قسم شرطة المطار",
      102: "قسم شرطة الضباب",
      103: "قسم شرطة الشهيد الحكيمي",
      104: "قسم شرطة بيرباشا",
      105: "قسم شرطة النصر",
      106: "قسم شرطة الحصب",
      107: "قسم شرطة الدحي",
      108: "قسم شرطة الجديري",
      109: "قسم شرطة 11 فبراير",
      110: "قسم شرطة صينة",
      111: "قسم شرطة باب موسى",
      112: "قسم شرطة 26 سبتمبر",
      113: "قسم شرطة الباب الكبير",
      114: "قسم شرطة 22 مايو",
      115: "قسم شرطة السواتي",
      116: "قسم شرطة الفقيد المغبشي",
      117: "قسم شرطة صالة",
      118: "قسم شرطة الجمهوري",
      119: "قسم شرطة الثورة"
    };
    const _biggerFont = TextStyle(fontSize: 18.0);

    Widget _buildRow(int idx) {
      return Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('${idx - 100 }'),
            ),
            title: Text(
              items[idx]!,
              style: _biggerFont,
            ),
            onTap: () {
              PData.updateToOffice(items[idx]!,idx);
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => startCompose()));
              //  Navigator.pop(context);
            },
          ),
          const Divider(
            color: Color.fromARGB(83, 85, 77, 77),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("إختيار الجهة"),
      ),
      body: ListView.builder(
        itemCount: numItems,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) {
          final index = i + 101;
          return _buildRow(index);
        },
      ),
    );
  }
}
