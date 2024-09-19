import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';

class GameScreenPage extends StatefulWidget {
  const GameScreenPage({Key? key}) : super(key: key);

  @override
  State<GameScreenPage> createState() => _GameScreenPageState();
}

class _GameScreenPageState extends State<GameScreenPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('Game Screen Init');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*.825;
    final width = MediaQuery.of(context).size.width*.825;
    return Container(
      alignment: Alignment.topCenter,
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color:MyColor.black_absolute,
        border: Border(
        right: BorderSide(width: 2.0, color: MyColor.yellow_bg2),
        bottom: BorderSide(width: 2.0, color: MyColor.yellow_bg2),
        ),
        // borderRadius: BorderRadius.circular(MyString.padding16)
      ),
      child: const Center(
        child: Text('screen', style: TextStyle(color: MyColor.white)),
      ),
    );
  }
}
