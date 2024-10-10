import 'package:flutter/material.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/xgame/bottom/game.odometer.child.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';

// class GameJackpot extends StatelessWidget {
//   final SocketManager socketManager;

//   const GameJackpot({required this.socketManager, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         lazy: false,
//         create: (_) => JackpotBloc(httpClient: http.Client())..add(JackpotFetched()),
//         child: GameJackpotBody(socketManager: socketManager,));
//   }
// }

class GameJackpot extends StatefulWidget {
  final SocketManager socketManager;

  const GameJackpot({
    required this.socketManager,
    Key? key,
  }) : super(key: key);

  @override
  State<GameJackpot> createState() => _GameJackpotState();
}

class _GameJackpotState extends State<GameJackpot> {
  @override
  void initState() {
    debugPrint("INIT GAME JACKPOT");
    widget.socketManager.emitJackpotNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width =  MediaQuery.of(context).size.width * SizeConfig.screenVerMain;
    final double height =  MediaQuery.of(context).size.height * SizeConfig.controlVerMain;

    return SizedBox(
      width: width,
      height: height,
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: SocketManager().dataStreamJackpotNumber,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: MyColor.white,
              strokeWidth: .5,
            ));
          } else if (snapshot.hasError) {
            return textcustom(text: 'error ${snapshot.error}');
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              snapshot.data == []) {
            return const Center(child: Icon(Icons.do_not_disturb_alt_sharp));
          }
          late final  data = snapshot.data as List<Map<String, dynamic>>;
          late final int jackpotValue = data[0]['returnValue'].round();
          late final int jackpotValueOld = data[0]['oldValue'].round();
          late final bool drop = data[0]['drop'];
          return Container(
              height: height,
              alignment: Alignment.centerLeft,
              // color:MyColor.whiteOpacity,
              width: width,
              child:
              //  Text(
              //   '${jackpotValue} --- ${jackpotValueOld}',
              //   style: TextStyle(color: MyColor.white, ),
              // )
               GameOdometerChild(height: height,width: width,
                startValue1: jackpotValueOld,
                endValue1: jackpotValue,
                title1: "VEGAS",
                droppedJP: drop,
               )
              );
        },
      ),
    );
  }
}
