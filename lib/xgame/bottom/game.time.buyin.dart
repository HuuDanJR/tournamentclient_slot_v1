import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_client/lib/models/timeModel.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/bloc_timer_bottom/timerbottom_bloc.dart';
import 'package:tournament_client/xgame/bottom/game.time.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';

class GameTimeBuyIn extends StatelessWidget {
  final SocketManager socketManager;
  final double width;
  final int durationMinutes; // Input duration in minutes
  final double height;

  const GameTimeBuyIn({
    required this.socketManager,
    required this.width,
    required this.height,
    required this.durationMinutes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TimerBottomBloc(initialDuration: durationMinutes * 60),
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: SocketManager().dataStreamTime,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return textcustom(text: 'error ${snapshot.error}');
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Icon(Icons.do_not_disturb_alt_sharp));
          }

          // Parse the data from the socket stream
          TimeModelList timeModelList = TimeModelList.fromJson(snapshot.data!);
          int totalSeconds = durationMinutes * 60; // Calculate total duration in seconds
          int status = timeModelList.list.first.status;

          // Trigger BLoC events based on the status from the stream
          if (status == 1) {
            // Use the custom duration if provided
            context.read<TimerBottomBloc>().add(StartTimer(durationInSeconds: totalSeconds));
          } else if (status == 2) {
            context.read<TimerBottomBloc>().add(PauseTimer());
          } else if (status == 3) {
            context.read<TimerBottomBloc>().add(ResumeTimer());
          } else if (status == 4) {
            context.read<TimerBottomBloc>().add(StopTimer());
          }

          return BlocBuilder<TimerBottomBloc, TimerBottomState>(
            builder: (context, state) {
              int minutes = state.duration ~/ 60;
              int seconds = state.duration % 60;
              String formattedMinutes = minutes.toString().padLeft(2, '0');
              String formattedSeconds = seconds.toString().padLeft(2, '0');
              String formattedMinutesInput =(totalSeconds ~/ 60).toString().padLeft(2, '0');
              String formattedSecondsInput = (totalSeconds % 60).toString().padLeft(2, '0');
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Text('${formattedMinutesInput} : ${formattedSecondsInput}}',style: TextStyle(color:MyColor.white),),
                  totalSeconds > 0 ?
                       ImageBoxTitle(
                          hasChild: true,
                          textSize: MyString.padding42,
                          width: width,
                          height: height,
                          asset: "asset/round.png",
                          title: "BUY-IN AT",
                          sizeTitle: MyString.padding18,
                          text: state.status == TimerBottomStatus.initial || state.status == TimerBottomStatus.finish ?'$formattedMinutesInput:$formattedSecondsInput'  :  '$formattedMinutes:$formattedSeconds',
                        ) 
                      : totalSeconds == 0 ? Text('end finish') :  Container(),
                  if (state.status == TimerBottomStatus.paused)
                    buttonStatus(width, height)
                  else
                    const SizedBox(),
                ],
              );
              // switch (state.status) {
              //   case TimerBottomStatus.initial:
              //     return Text('initial');
              //   case TimerBottomStatus.finish:
              //     return ImageBoxTitle(
              //       hasChild: true,
              //       textSize: MyString.padding42,
              //       width: width,
              //       height: height,
              //       asset: "asset/round.png",
              //       title: "BUY-IN AT",
              //       sizeTitle: MyString.padding18,
              //        text: '$formattedMinutes:$formattedSeconds',
              //     );
              //   case TimerBottomStatus.ticking:
              //     return ImageBoxTitle(
              //       hasChild: true,
              //       textSize: MyString.padding42,
              //       width: width,
              //       height: height,
              //       asset: "asset/round.png",
              //       title: "BUY-IN AT",
              //       sizeTitle: MyString.padding18,
              //       text: '$formattedMinutes:$formattedSeconds',
              //     );
              //   case TimerBottomStatus.paused:
              //     return Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         ImageBoxTitle(
              //           hasChild: true,
              //           textSize: MyString.padding42,
              //           width: width,
              //           height: height,
              //           asset: "asset/round.png",
              //           title: "BUY-IN AT",
              //           sizeTitle: MyString.padding18,
              //           text: '$formattedMinutes:$formattedSeconds',
              //         ),
              //         buttonStatus(width, height),
              //       ],
              //     );
              //   default:
              //     return SizedBox();
              // }
            },
          );
        },
      ),
    );
  }
}
