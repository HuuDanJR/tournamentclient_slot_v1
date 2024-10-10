import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';
import 'package:tournament_client/xgame/bottom/widget/jackpot.item.dart';

class GameOdometerChild extends StatefulWidget {
  final int startValue1;
  final int endValue1;
  final String title1;
  final double width;
  final bool droppedJP;
  final double height;

  const GameOdometerChild({
    Key? key,
    required this.startValue1,
    required this.endValue1,
    required this.title1,
    required this.width,
    required this.height,
    required this.droppedJP,
  }) : super(key: key);

  @override
  _GameOdometerChildState createState() => _GameOdometerChildState();
}

class _GameOdometerChildState extends State<GameOdometerChild>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<OdometerNumber> animation;

    bool showDroppedText = false; // To show the delayed "JP Dropped" text


  // Set the base duration default to 10 seconds
  final int baseDurationDefault = 10;

  // Function to calculate animation duration based on the difference between start and end values
  Duration _calculateDuration(int startValue, int endValue) {
    // const int baseValue = 100;
    // final int difference = (endValue - startValue).abs(); // Absolute difference
    // return Duration(
    //   seconds: (difference * baseDurationDefault) ~/ baseValue,
    // ); // Adjust duration
    return Duration(seconds: baseDurationDefault);
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _handleDropLogic(); // Handle the "JP Dropped" logic

    animationController.forward();
  }

  // Handle the "JP Dropped" logic based on the `droppedJP` flag
  void _handleDropLogic() {
    if (widget.droppedJP) {
      Future.delayed(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            showDroppedText = true;
          });
        }
      });
    }
  }

  void _initializeAnimation() {
    final duration = _calculateDuration(widget.startValue1, widget.endValue1);
    animationController = AnimationController(
      duration: duration,
      vsync: this,
    );

    animation = OdometerTween(
      begin: OdometerNumber(widget.startValue1),
      end: OdometerNumber(widget.endValue1),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Easing.standard,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant GameOdometerChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if either the start or end values have changed
    if (widget.startValue1 != oldWidget.startValue1 ||
        widget.endValue1 != oldWidget.endValue1) {
      animationController.dispose(); // Dispose of the old controller
      _initializeAnimation(); // Reinitialize with new values
      animationController.forward(from: 0.0); // Restart the animation
    }
    if (widget.droppedJP != oldWidget.droppedJP) {
      _handleDropLogic(); // Re-handle the drop logic if it changes
    }
  }

  @override
  void dispose() {
    animationController.dispose();
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
          imageBoxTitleWidget(
            textSize: MyString.padding28,
            width: SizeConfig.jackpotWithItem,
            height: widget.height * SizeConfig.jackpotHeightRation,
            asset: "asset/eclip.png",
            title: widget.title1,
            drop: widget.droppedJP,
            widgetDrop: 
              showDroppedText?  Text(
                "JP Dropped", // First text
                style: TextStyle(
                  color: MyColor.white,
                  fontSize: MyString.padding16,
                  fontWeight: FontWeight.w600, // Non-bold for first text
                ),
                textAlign: TextAlign.center, // Center align if needed
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false, // Controls the height behavior
                  applyHeightToLastDescent: false,
                ),
            ):Container(),
            sizeTitle: MyString.padding14,
            widget: SlideOdometerTransition(
              verticalOffset: MyString.padding32,
              letterWidth: MyString.padding24,
              odometerAnimation: animation,
              numberTextStyle: const TextStyle(
                fontSize: MyString.padding32,
                color: MyColor.yellowMain,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
