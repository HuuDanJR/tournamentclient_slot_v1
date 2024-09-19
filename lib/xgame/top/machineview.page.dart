import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/xpage/home/home_realtime.dart';
import 'package:tournament_client/xpage/home/home_topranking.dart';

class MachineViewPage extends StatelessWidget {
  const MachineViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final heightItem = height * .5;
    final widthItem = width * .5;
    final paddingHorizontal = MyString.padding16;
    final paddingHorizontalDouble = MyString.padding16*2;
    final paddingHorizontalHalf = MyString.padding12;
    final paddingVertical = MyString.padding16;
    // final width = width
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/bg.jpg'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.none,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: width, height: heightItem),
            SizedBox(
              width: width,
              height: heightItem,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //top ranking
                  Container(
                    margin:  EdgeInsets.only(
                      top: paddingVertical,
                      bottom: paddingVertical,
                      left: paddingHorizontal,
                      right: paddingHorizontalHalf,
                    ),
                    decoration: BoxDecoration(
                        color: MyColor.whiteOpacity,
                        borderRadius:
                            BorderRadius.circular(MyString.padding16)),
                    width: widthItem - paddingHorizontalDouble,
                    height: heightItem - paddingVertical,
                    child: HomeTopRankingPage(
                        title: MyString.APP_NAME,
                        url: MyString.BASEURL,
                        selectedIndex: MyString.DEFAULTNUMBER),
                  ),
                  //realtime ranking
                  Container(
                    decoration: BoxDecoration(
                        color: MyColor.whiteOpacity,
                        borderRadius:  BorderRadius.circular(MyString.padding16)),
                    margin:  EdgeInsets.only(
                      top: paddingVertical,
                      bottom: paddingVertical,
                      right: paddingHorizontal,
                      left: paddingHorizontalHalf,),
                    width: widthItem - paddingHorizontalDouble,
                    height: heightItem - paddingVertical,
                    child: HomeRealTimePage(
                      url: MyString.BASEURL,
                      selectedIndex: MyString.DEFAULTNUMBER,
                      title: MyString.APP_NAME,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
