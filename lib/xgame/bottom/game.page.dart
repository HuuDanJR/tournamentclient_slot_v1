import 'package:flutter/material.dart';
import 'package:tournament_client/xgame/bottom/game.setting.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: width,
            height: height / 2,
            child: const GameSettingPage()
          ),
          Container(
            alignment: Alignment.center,
            width: width,
            height: height / 2,
            child: const Text('setting realtime'),
          ),
        ],
      ),
    )
    );
  }
}
