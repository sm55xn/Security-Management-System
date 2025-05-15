import 'package:flutter/material.dart';
import 'package:my_security/Provider/ProvideData.dart';
import 'package:my_security/view/Home/create_report.dart';
import 'package:provider/provider.dart';

class ListOffice extends StatelessWidget {
  const ListOffice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var PData = Provider.of<ProvideData>(context, listen: true);
    const numItems = 11;
    final Map<int, String> items = {
      201: "مكتب الصحة",
      202: "مكتب التحسين والنظافة",
      203: "مكتب الهجرة والجوزات",
      204: "مكتب الأحوال المدنية",
      205: "مكتب الشؤون الإجتماعية",
      206: "مكتب الأشغال العامة",
      207: "مكتب الأوقاف والإرشاد",
      208: "مكتب شرطة المرور",
      209: "مكتب الضرائب",
      210: "مكتب الدفاع المدني",
      211: "مكتب الجودة والمقاييس",
    };

    const _biggerFont = TextStyle(fontSize: 18.0);

    Widget _buildRow(int idx) {
      return Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('${idx - 200}'),
            ),
            title: Text(
              items[idx]!,
              style: _biggerFont,
            ),
            onTap: () {
              PData.updateToOffice(items[idx]!, idx);
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
        title: Text("إختيار المكتب"),
      ),
      body: ListView.builder(
        itemCount: numItems,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) {
          final index = i + 201;
          return _buildRow(index);
        },
      ),
    );
  }
}
