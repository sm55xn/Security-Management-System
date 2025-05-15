import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';

class Noti extends StatefulWidget {
  const Noti({super.key});

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  LocalNotification? ReportNoti = LocalNotification(
    identifier: 'ReportNoti',
    title: 'بلاغ جديد                      ',
    body: 'هل تريد عرض البلاغ الوارد؟',
    actions: [
      LocalNotificationAction(
        text: 'لا',
      ),
      LocalNotificationAction(
        text: 'نعم',
      ),
    ],
  );

  final List<LocalNotification> _notificationList = [];

  @override
  void initState() {
    super.initState();

    ReportNoti?.onShow = () {
      if (kDebugMode) {
        print('onShow ${ReportNoti?.identifier}');
      }
    };
    ReportNoti?.onClose = (closeReason) {
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
          // do something
          break;
        case LocalNotificationCloseReason.timedOut:
          // do something
          break;
        default:
      }
      String log = 'onClose ${ReportNoti?.identifier} - $closeReason';
      if (kDebugMode) {
        print(log);
      }
      BotToast.showText(text: log);
    };
    ReportNoti?.onClick = () {
      String log = 'onClick ${ReportNoti?.identifier}';
      if (kDebugMode) {
        print(log);
      }
      BotToast.showText(text: log);
    };
    ReportNoti?.onClickAction = (actionIndex) {
      String log = 'onClickAction ${ReportNoti?.identifier} - $actionIndex';
      if (kDebugMode) {
        print(log);
      }
      BotToast.showText(text: log);
    };
   
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
