import 'package:flutter/material.dart';
import 'package:my_security/view/Privacy.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("حول التطبيق",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          const SliverToBoxAdapter(
            child: Divider(
              color: Color(0xff052659),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                      child: Image.asset(
                    "assets/ic_launcher.png",
                    height: 150,
                  )),
                  const SizedBox(height: 10),
                  const Text(
                    "الإصدار :1.0.0",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: const Text(
                            "سياسة الخصوصية",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                          onPressed: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Privacy();
                              }))),
                      const Text(
                        "  •  ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                          child: const Text(
                            "إتفاقية الإستخدام",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                          onPressed: () {}),
                    ],
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    " هذا التطبيق يقدم خدمة للمواطنين بحيث يمكنهم من إرسال البلاغات إلى اقسام الشرطة أو المكاتب الخدمية  واستلام الردود منها كما يمكن من متابعة الأخبار الأمنية والتفاعل معها ومعرفة التغيرات الحالية. نهدف من خلال هذا العمل إلى تحسين أداء الأجهزة الأمنية ومكاتب الخدمات الحكومية في البلاد من خلال سرعة الإستجابة وتعزيز الثقة بين الأجهزة الأمنية والمواطنين. ",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text("حسناً"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
