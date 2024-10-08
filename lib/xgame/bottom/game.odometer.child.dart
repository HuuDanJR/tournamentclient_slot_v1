import 'dart:math';
import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';

class GameOdometerChild extends StatefulWidget {
  final int startValue1;
  final int startValue2;
  final int endValue2;
  final int endValue1;
  final String title1;
  final String title2;
  final double width;
  final double height;
  const GameOdometerChild({
    Key? key,
    required this.startValue1,
    required this.endValue1,
    required this.startValue2,
    required this.endValue2,
    required this.title1,
    required this.title2,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _GameOdometerChildState createState() => _GameOdometerChildState();
}

class _GameOdometerChildState extends State<GameOdometerChild>
    with SingleTickerProviderStateMixin {
  final double _startValue = 100.00;
  double _targetValue = 100.00; // New target value for odometer
  AnimationController? animationController;
  late Animation<OdometerNumber> animation;
  late double randomValue; // Random value between 100 and 150

  // Define base duration default
  final int baseDurationDefault = 60; // in seconds

  // Function to calculate animation duration based on randomValue
  Duration _calculateDuration(double value) {
    const int baseValue = 100;
    return Duration(
        seconds: (value - baseValue) *
            baseDurationDefault ~/
            baseValue); // Use baseDurationDefault
  }

  void _generateRandomTarget() {
    setState(() {
      randomValue =
          Random().nextInt(51) + 100; // Random value between 100 and 150
      _targetValue = randomValue;

      // Reset the controller and animation
      animationController?.reset(); // Instead of dispose, just reset it
      final duration = _calculateDuration(randomValue); // Calculate the duration
      animationController?.duration = duration; // Adjust duration

      animation = OdometerTween(
        begin: OdometerNumber(_startValue), // Start from the current value
        end: OdometerNumber(_targetValue), // Go to the new random target
      ).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Easing.linear,
        ),
      );
      animationController?.forward(); // Start the animation
      // Print the second value for the current random number
      debugPrint("Duration for random value $randomValue: ${duration.inSeconds} seconds");
    });
  }

  @override
  void initState() {
    super.initState();
    // Initial setup with default start value and animation
    animationController = AnimationController(
      duration:
          Duration(seconds: baseDurationDefault), // Use baseDurationDefault
      vsync: this,
    );

    // Call _generateRandomTarget to set the initial target value
    _generateRandomTarget();

    animation = OdometerTween(
      begin: OdometerNumber(_startValue),
      end: OdometerNumber(_targetValue),
    ).animate(
      CurvedAnimation(parent: animationController!, curve: Easing.linear),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageBoxTitleWidget(
            textSize: MyString.padding28,
            width: SizeConfig.jackpotWithItem,
            height: widget.height * SizeConfig.jackpotHeightRation,
            asset: "asset/eclip.png",
            title: "${widget.title1}",
            sizeTitle: MyString.padding14,
            widget: GestureDetector(
              onTap: _generateRandomTarget,
              child: SlideOdometerTransition(
                verticalOffset: MyString.padding32,
                letterWidth: MyString.padding24,
                odometerAnimation: animation,
                numberTextStyle: const TextStyle(
                    fontSize: MyString.padding32,
                    color: MyColor.yellowMain,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(
            width: MyString.padding16,
          ),
          // ImageBoxTitleWidget(
          //     textSize: MyString.padding28,
          //     width: SizeConfig.jackpotWithItem,
          //     height: widget.height * SizeConfig.jackpotHeightRation,
          //     asset: "asset/eclip.png",
          //     title: "${widget.title2}",
          //     sizeTitle: MyString.padding14,
          //     widget: 
          //     AnimatedSlideOdometerNumber(
          // letterWidth: 20,
          // odometerNumber: OdometerNumber(_targetValue),
          // duration: const Duration(seconds: 1),
          // groupSeparator: const Icon(Icons.merge_rounded),
          // verticalOffset: 50,
          // numberTextStyle: const TextStyle(
          //           fontSize: MyString.padding32,
          //           color: MyColor.yellowMain,
          //           fontWeight: FontWeight.w700),
        // ),),
        ],
      ),
    );
  }
}
