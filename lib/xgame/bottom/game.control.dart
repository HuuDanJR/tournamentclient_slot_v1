import 'package:flutter/material.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/game.setting.dart';
import 'package:tournament_client/xgame/bottom/game.time.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';

class GameControlPage extends StatelessWidget {
  final SocketManager socketManager;
  final String selectedNumber;
  final String uniqueId;
  const GameControlPage({required this.socketManager,required this.selectedNumber,required this.uniqueId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final heightItem = height * SizeConfig.controlItemMain;
    final heightItem2 = height * SizeConfig.controlItemSub;
    final width = MediaQuery.of(context).size.width * SizeConfig.controlVerMain;
    return Container(
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(vertical: MyString.padding16),
      width: width,
      height: height,
      // color:MyColor.whiteOpacity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              // color:MyColor.bedge.withOpacity(.5),
              width: width,
              height: heightItem,
              child: GameSettingPage(
                  socketManager: socketManager,
                  uniqueId:uniqueId,
                  selectedNumber:selectedNumber,
                  width: width,
                  height: heightItem),
            ),
            Container(
              alignment: Alignment.center,
              width: width,
              height: heightItem2,
              // color: MyColor.whiteOpacity,
              child: GameTime(
                  socketManager: socketManager,
                  width: width,
                  height: heightItem2),
            ),
          ]),
    );
  }
}
