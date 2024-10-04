import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';

class GameJackpot extends StatelessWidget {

  const GameJackpot({
   
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width*SizeConfig.screenVerMain;
    final double height = MediaQuery.of(context).size.height *SizeConfig.controlVerSub;

    return Container(
      width: width,
      height: height,
      // color:MyColor.whiteOpacity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(
          //   width: MyString.padding24,
          // ),
          ImageBox(
            hasChild: true,
            textSize: MyString.padding28,
            width: SizeConfig.jackpotWithItem,
            height: height * SizeConfig.jackpotHeightRation,
            asset: "asset/eclip.png",
            title: "VEGAS",
            sizeTitle: MyString.padding14,
            text: '\$150',
          ),
          const SizedBox(
            width: MyString.padding16,
          ),
          ImageBox(
            hasChild: true,
            textSize: MyString.padding28,
            width: SizeConfig.jackpotWithItem,
            height: height * SizeConfig.jackpotHeightRation,
            asset: "asset/eclip.png",
            title: "LUCKY",
            sizeTitle: MyString.padding14,
            text: '\$50',
          ),
        ],
      ),
    );
  }
}
