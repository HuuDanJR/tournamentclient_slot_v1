// import 'package:flutter/material.dart';
// import 'package:tournament_client/lib/socket/socket_manager.dart';
// import 'package:tournament_client/utils/mycolors.dart';
// import 'package:tournament_client/widget/text.dart';
// import 'package:tournament_client/xgame/bottom/game.odometer.child.dart';
// import 'package:tournament_client/xgame/bottom/size.config.dart';

// // class GameJackpot extends StatelessWidget {
// //   final SocketManager socketManager;

// //   const GameJackpot({required this.socketManager, Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //         lazy: false,
// //         create: (_) => JackpotBloc(httpClient: http.Client())..add(JackpotFetched()),
// //         child: GameJackpotBody(socketManager: socketManager,));
// //   }
// // }

// class GameJackpot extends StatefulWidget {
//   final SocketManager socketManager;

//   const GameJackpot({
//     required this.socketManager,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<GameJackpot> createState() => _GameJackpotState();
// }

// class _GameJackpotState extends State<GameJackpot> {
//   @override
//   void initState() {
//     debugPrint("INIT GAME JACKPOT");
//     widget.socketManager.emitJackpot();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width * SizeConfig.screenVerMain;
//     final double height =  MediaQuery.of(context).size.height * SizeConfig.controlVerSub;

//     return SizedBox(
//       width: width,
//       height: height,
//       child: StreamBuilder<List<Map<String, dynamic>>>(
//         stream: SocketManager().dataStreamJackpot,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//                 child: CircularProgressIndicator(
//               color: MyColor.white,
//               strokeWidth: .5,
//             ));
//           } else if (snapshot.hasError) {
//             return textcustom(text: '${snapshot.error}');
//           }
//           if (snapshot.data!.isEmpty ||
//               snapshot.data == null ||
//               snapshot.data == []) {
//             return const Center(child: Icon(Icons.do_not_disturb_alt_sharp));
//           }
//           final data = snapshot.data as List<Map<String, dynamic>>;
//           late final vegasPrice = data.first; // Access the first jackpot entry (if available)
//           late final luckyPrice = data.last; // Access the first jackpot entry (if available)
//           return GameOdometerChild(
//             width:width,height:height,
//             startValue1: vegasPrice['startValue'], endValue1: vegasPrice['endValue'], 
//             startValue2: luckyPrice['startValue'], endValue2: luckyPrice['endValue'], 
//             title1: "${vegasPrice['name']}", title2: "${luckyPrice['name']}");

//           // SizedBox(
//           //     height: height,
//           //     width: width,
//           //     child: Text('${vegasPrice['name']}'));

//           //   return Container(
//           //   width: width,
//           //   height: height,
//           //   // color:MyColor.whiteOpacity,
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.start,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       ImageBoxTitle(
//           //         hasChild: true,
//           //         textSize: MyString.padding28,
//           //         width: SizeConfig.jackpotWithItem,
//           //         height: height * SizeConfig.jackpotHeightRation,
//           //         asset: "asset/eclip.png",
//           //         title: "${vegasPrice['name']}",
//           //         sizeTitle: MyString.padding14,
//           //         text: '\$150',
//           //       ),
//           //       const SizedBox(
//           //         width: MyString.padding16,
//           //       ),
//           //       ImageBoxTitle(
//           //         hasChild: true,
//           //         textSize: MyString.padding28,
//           //         width: SizeConfig.jackpotWithItem,
//           //         height: height * SizeConfig.jackpotHeightRation,
//           //         asset: "asset/eclip.png",
//           //         title: "${luckyPrice['name']}",
//           //         sizeTitle: MyString.padding14,
//           //         text: '\$50',
//           //       ),
//           //     ],
//           //   ),
//           // );
//         },
//       ),
//     );
//   }
// }
