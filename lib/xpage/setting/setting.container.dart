import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/xpage/setting/setting.machine.page.dart';
import 'package:tournament_client/xpage/setting/setting.operator.dart';
import 'package:tournament_client/xpage/setting/setting.page.dart';


class SettingContainer extends StatelessWidget {
  const SettingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: textcustom(text: 'Settings Real Time', size: MyString.padding16),
        actions: const [],
      ),
      body: SizedBox(
        width: width,
        height:height,
        child:   const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SettingOperator(),
            SettingPage(),
            SettingMachinePage(),
            
            
          ]
        ),
      )
    );
  }
}
