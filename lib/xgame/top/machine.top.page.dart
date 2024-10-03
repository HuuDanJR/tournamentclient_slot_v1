import 'package:flutter/material.dart';
import 'package:tournament_client/authentication/viewpage.child.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/xpage/home/home_realtime.dart';
import 'package:tournament_client/xpage/home/home_topranking.dart';

class MachineTopPage extends StatelessWidget {
  const MachineTopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
          color: MyColor.whiteOpacity,
          borderRadius: BorderRadius.circular(MyString.padding24),
          // No Border 
          // border: Border.all(
          //   color:MyColor.yellowMain,
          //   width: MyString.padding04
          // )
        ),
        width:width,
        height:height,
        child: ViewPageChild(
                    url: MyString.BASEURL,
                    child2 : HomeRealTimePage(
                        title: MyString.APP_NAME,
                        url: MyString.BASEURL,
                        selectedIndex: MyString.DEFAULTNUMBER),
                    child: 
                      HomeTopRankingPage(
                        title: MyString.APP_NAME,
                        url: MyString.BASEURL,
                        selectedIndex: MyString.DEFAULTNUMBER),
                ),
      );
  }
}
