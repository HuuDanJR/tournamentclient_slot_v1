import 'package:flutter/material.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/game.control.dart';
import 'package:tournament_client/xgame/bottom/game.screen.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final socketManager = SocketManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('Game Setting Init');
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
    return Scaffold(
      body:Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        image: DecorationImage(
        image: Image.asset('asset/bg.jpg').image,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
      ),),
      child: Stack(
        children: [
          const GameScreenPage(),  
          Positioned(
            top: 0,
            right: 0,
            child: GameControlPage(
              socketManager:socketManager
            ))         
        ],
      ),
      
      
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Container(
      //       alignment: Alignment.center,
      //       width: width,
      //       height: height / 2,
      //       child:  GameSettingPage(
      //         socketManager: socketManager,
      //       )
      //     ),
      //     Container(
      //       alignment: Alignment.center,
      //       width: width,
      //       height: height / 2,
      //       child:  GameTime(
      //         socketManager: socketManager
      //       ),
      //     ),
      //   ],
      // ),
          )
    );
  }
}
