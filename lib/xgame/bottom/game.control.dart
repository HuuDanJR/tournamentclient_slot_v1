import 'package:flutter/material.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/xgame/bottom/game.setting.dart';
import 'package:tournament_client/xgame/bottom/game.time.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';

class GameControlPage extends StatelessWidget {
  final SocketManager socketManager;
  const GameControlPage({required this.socketManager, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final heightItem = height *SizeConfig.controlItemMain;
    final heightItem2 = height *SizeConfig.controlItemSub;
    final width = MediaQuery.of(context).size.width*SizeConfig.controlVerMain;
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
            Container(
              // color:MyColor.bedge,
              width: width,
              height: heightItem,
              child: GameSettingPage(socketManager: socketManager,width:width,height:heightItem),
            ),
            Container(
              alignment: Alignment.center,
              width: width,
              height: heightItem2,
              // color: MyColor.whiteOpacity,
              child: GameTime(socketManager: socketManager,width:width,height:heightItem2),
            ),
           
        ]
      ),
    );
  }
}
