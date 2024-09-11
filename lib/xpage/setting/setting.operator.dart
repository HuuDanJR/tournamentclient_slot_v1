import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/textfield.dart';
import 'package:tournament_client/xpage/setting/bloc_timer/timer_bloc.dart';

class SettingOperator extends StatelessWidget {
  const SettingOperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(), child: const SettingOperatorBody());
  }
}

class SettingOperatorBody extends StatelessWidget {
  const SettingOperatorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final TextEditingController controllerTimer = TextEditingController();
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final minutes = (state.duration / 60).floor();
        final seconds = (state.duration % 60).floor();
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: MyString.padding16, vertical: MyString.padding04),
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mytextFieldTitleSizeIcon(
                            width: width/3,
                            icon: const Icon(Icons.timer),
                            label: "Timer Minutes",
                            text: '5',
                            controller: controllerTimer,enable: true,textinputType: TextInputType.number),  
              const SizedBox(
                width: MyString.padding16,
              ),
              _buildControlButtons(context, state,controllerTimer),
              const SizedBox(
                width: MyString.padding16,
              ),
              Text(
                // Display the timer countdown in MM:SS format
                '$minutes:${seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: MyString.padding24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Method to display the control buttons
Widget _buildControlButtons(BuildContext context, TimerState state,TextEditingController? controller) {
  final timerBloc = context.read<TimerBloc>();

  if (state.status == TimerStatus.initial) {
    return TextButton.icon(
      icon: Icon(Icons.play_arrow, color: MyColor.green),
      onPressed: () {
        _showConfirmationDialog(context, "Start Game", () {
          // Convert the entered duration to seconds
              final int customDuration = int.tryParse(controller!.text) ?? 5;
              final durationInSeconds = customDuration * 60; // Convert minutes to seconds
              timerBloc.add(StartTimer(durationInSeconds: durationInSeconds));
        });
      },
      label: const Text('START'),
    );
  } else if (state.status == TimerStatus.ticking) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.pause),
          onPressed: () {
            _showConfirmationDialog(context, "Pause Game", () {
              timerBloc.add( PauseTimer());
            });
          },
          label: const Text('PAUSE'),
        ),
        const SizedBox(width: MyString.padding16),
        TextButton.icon(
          icon: Icon(Icons.stop, color: MyColor.red),
          onPressed: () {
            _showConfirmationDialog(context, "Stop Game", () {
              timerBloc.add( StopTimer());
            });
          },
          label: const Text('STOP'),
        ),
      ],
    );
  } else if (state.status == TimerStatus.paused) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          icon: Icon(Icons.play_arrow_outlined, color: MyColor.green),
          onPressed: () {
            _showConfirmationDialog(context, "Resume Game", () {
              timerBloc.add( ResumeTimer());
            });
          },
          label: const Text('RESUME'),
        ),
        const SizedBox(width: MyString.padding16),
        TextButton.icon(
          icon: Icon(Icons.stop, color: MyColor.red),
          onPressed: () {
            _showConfirmationDialog(context, "Stop Game", () {
              timerBloc.add( StopTimer());
            });
          },
          label: const Text('STOP'),
        ),
      ],
    );
  } else if (state.status == TimerStatus.finish) {
    return TextButton.icon(
      icon: Icon(Icons.play_arrow, color: MyColor.green_accent),
      onPressed: () {
        _showConfirmationDialog(context, "Restart Game", () {
          final int customDuration = int.tryParse(controller!.text) ?? 5;
          final durationInSeconds = customDuration * 60; // Convert minutes to seconds
          timerBloc.add( StartTimer(durationInSeconds: durationInSeconds));
        });
      },
      label: const Text('RESTART'),
    );
  }

  return Container();
}

// Method to show a confirmation dialog
Future<void> _showConfirmationDialog(
  BuildContext context,
  String actionTitle,
  VoidCallback onConfirmed,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(actionTitle),
        content: const Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false); // User pressed NO
            },
            child: const Text('NO'),
          ),
          TextButton.icon(
            icon: Icon(Icons.add_sharp, color: MyColor.red_accent),
            onPressed: () {
              Navigator.of(dialogContext).pop(true); // User pressed YES
            },
            label: const Text('YES'),
          ),
        ],
      );
    },
  );

  if (result == true) {
    onConfirmed(); // Call the action if the user pressed YES
  }
}
