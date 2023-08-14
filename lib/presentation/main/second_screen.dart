import 'package:flutter/material.dart';
import 'package:onetouchtimer/core/alarm/alarm.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key, this.payload}) : super(key: key);

  String? payload;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

NotifyHelper notifyHelper = NotifyHelper();

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    NotifyHelper notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.scheduledNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            notifyHelper.displayNotification(
                title: '원터치 알람', body: 'test body', payload: 'test');
          },
          child: Text('text')),
    );
  }
}
