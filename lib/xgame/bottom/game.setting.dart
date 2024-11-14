import 'package:flutter/material.dart';
import 'package:tournament_client/lib/models/settingModel.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/game.time.buyin.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';

class GameSettingPage extends StatefulWidget {
  final SocketManager socketManager;
  final String selectedNumber;
  final double width;
  final double height;
  const GameSettingPage({
    required this.socketManager,
    required this.width,
    required this.height,
    required this.selectedNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<GameSettingPage> createState() => _GameSettingPageState();
}

class _GameSettingPageState extends State<GameSettingPage> {
  @override
  void initState() {
    widget.socketManager.emitSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: SocketManager().dataStreamSetting,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return textcustom(text: '${snapshot.error}');
        }
        if (snapshot.data!.isEmpty ||
            snapshot.data == null ||
            snapshot.data == []) {
          return const Center(child: Icon(Icons.do_not_disturb_alt_sharp));
        }
        SettingModelList settingModelList =
            SettingModelList.fromJson(snapshot.data!);
        return SizedBox(
          // padding:const  EdgeInsets.symmetric(horizontal:MyString.padding08),
          width: widget.width,
          height: widget.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ImageBoxNoText(
              //   textSize: MyString.padding84,
              //   width: widget.width,
              //   height: widget.height * SizeConfig.controlItemHeightRatioBig,
              //   asset: "asset/circle.png",
              //   text: "${settingModelList.list.first.remaingame}",
              // ),

              ImageBoxNoText(
                  textSize: MyString.padding84,
                  width: widget.width,
                  height: widget.height * SizeConfig.controlItemHeightRatioBig,
                  asset: "asset/circle.png",
                  text: "${widget.selectedNumber}",
                  label: ""),

              Expanded(
                  child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageBoxTitle(
                      hasChild: true,
                      textSize: MyString.padding42,
                      width:
                          widget.width * SizeConfig.controlItemWidthRatioSmall,
                      height: widget.height *
                          SizeConfig.controlItemHeightRatioSmall,
                      asset: "asset/round.png",
                      title: "MIN BET",
                      sizeTitle: MyString.padding20,
                      text: "${settingModelList.list.first.minbet}",
                    ),
                    ImageBoxTitle(
                      hasChild: true,
                      textSize: MyString.padding42,
                      width:
                          widget.width * SizeConfig.controlItemWidthRatioSmall,
                      height: widget.height *
                          SizeConfig.controlItemHeightRatioSmall,
                      asset: "asset/round.png",
                      title: "MAX BET",
                      sizeTitle: MyString.padding20,
                      text: "${settingModelList.list.first.maxbet}",
                    ),
                    Container(
                      height: MyString.padding96,
                    ),
                    ImageBoxTitle(
                      hasChild: true,
                      textSize: MyString.padding42,
                      width:
                          widget.width * SizeConfig.controlItemWidthRatioSmall,
                      height: widget.height *
                          SizeConfig.controlItemHeightRatioSmall,
                      asset: "asset/round.png",
                      title: "ROUND",
                      sizeTitle: MyString.padding20,
                      text: '${settingModelList.list.first.remaingame}',
                    ),
                    // ImageBoxTitle(
                    //   hasChild: true,
                    //   textSize: MyString.padding42,
                    //   width: widget.width * SizeConfig.controlItemWidthRatioSmall,
                    //   height: widget.height * SizeConfig.controlItemHeightRatioSmall,
                    //   asset: "asset/round.png",
                    //   title: "BUY-IN AT",
                    //   sizeTitle: MyString.padding20,
                    //   text: settingModelList.list.first.roundtext,
                    // ),
                    // Text('${settingModelList.list.first.buyin}',style:TextStyle(color:MyColor.white))
                    GameTimeBuyIn(
                      socketManager: widget.socketManager,
                      durationMinutes: settingModelList.list.first.buyin,
                      width:
                          widget.width * SizeConfig.controlItemWidthRatioSmall,
                      height: widget.height *
                          SizeConfig.controlItemHeightRatioSmall,
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
