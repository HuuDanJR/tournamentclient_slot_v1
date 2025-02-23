import 'package:flutter/material.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/game.control.dart';
import 'package:tournament_client/xgame/bottom/game.jackpot.dart';
import 'package:tournament_client/xgame/bottom/game.screen.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';

class GamePage extends StatefulWidget {
  final String selectedNumber;
  final String uniqueId;
  const GamePage({Key? key,required this.selectedNumber,required this.uniqueId}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final socketManager = SocketManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('lib/xgame/bottom/game.page.dart');
    socketManager.initSocket();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socketManager.disposeSocket();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final double widthJP = width * SizeConfig.screenVerMain;
    final double heightJP = height * SizeConfig.controlVerMain;

    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('asset/bg.jpg').image,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.none,
        ),
      ),
      child: Stack(
        children: [
          const GameScreenPage(),
          //GAME CONTROL
          Positioned(
              top: 0,
              right: 0,
              child: GameControlPage(uniqueId:widget.uniqueId ?? "",socketManager: socketManager,selectedNumber:widget.selectedNumber)),
          //JACKPOT
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: widthJP,
              height: heightJP,
              // color:MyColor.whiteOpacity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GameJackpot(
                    socketManager: socketManager,
                  ),
                  SizedBox(
                    width: widthJP / 2,
                    height: heightJP / 2,
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     GameJackpot(
              //       socketManager: socketManager,
              //     ),
              //     GameJackpot2(
              //       socketManager: socketManager,
              //     ),
              //   ],
              // ),
            ),
          )
        ],
      ),
    ));
  }
}
