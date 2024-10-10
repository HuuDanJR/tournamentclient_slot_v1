import 'package:flutter/material.dart';
import 'package:tournament_client/lib/models/settingModel.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/size.config.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';

class GameSettingPage extends StatelessWidget {
  final SocketManager socketManager;
  final double width;
  final double height;
  const GameSettingPage({
    required this.socketManager,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

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
          return const  Center(child: Icon(Icons.do_not_disturb_alt_sharp));
        }
        SettingModelList settingModelList = SettingModelList.fromJson(snapshot.data!);
        return SizedBox(
          // padding:const  EdgeInsets.symmetric(horizontal:MyString.padding08),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageBoxNoText(
                textSize: MyString.padding96,
                width: width,
                height: height * SizeConfig.controlItemHeightRatioBig,
                asset: "asset/circle.png",
                text: "${settingModelList.list.first.remaingame}",
              ),
                // padding: const EdgeInsets.symmetric(horizontal: MyString.padding12),
              ImageBoxTitle(
                  hasChild: true,
                  textSize: MyString.padding36,
                  width: width* SizeConfig.controlItemWidthRatioSmall,
                  height: height * SizeConfig.controlItemHeightRatioSmall,
                  asset: "asset/round.png",
                  title: "MIN BET",
                  sizeTitle: MyString.padding18,
                  text: "${settingModelList.list.first.minbet}",
              ),
              const SizedBox(height: MyString.padding32,),
              ImageBoxTitle(
                  hasChild: true,
                  textSize: MyString.padding36,
                  width: width* SizeConfig.controlItemWidthRatioSmall,
                  height: height * SizeConfig.controlItemHeightRatioSmall,
                  asset: "asset/round.png",
                  title: "MAX BET",
                  sizeTitle: MyString.padding18,
                  text: "${settingModelList.list.first.maxbet}",
              ),
              const SizedBox(height: MyString.padding32,),
              ImageBoxTitle(
                        hasChild: true,
                        textSize: MyString.padding36,
                        width: width * SizeConfig.controlItemWidthRatioSmall,
                        height: height * SizeConfig.controlItemHeightRatioSmall,
                        asset: "asset/round.png",
                        title: "BUY-IN AT",
                        sizeTitle: MyString.padding18,
                        text: settingModelList.list.first.roundtext,
              ),
              // Expanded(
              //   child: Container(
              //     alignment: Alignment.bottomCenter,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         ImageBox(
              //           hasChild: true,
              //           textSize: MyString.padding24,
              //           width: width * SizeConfig.controlItemWidthRatioSmall,
              //           height: height * SizeConfig.controlItemHeightRatioSmall,
              //           asset: "asset/eclip.png",
              //           title: "BUY-IN AT",
              //           sizeTitle: MyString.padding14,
              //           text: settingModelList.list.first.roundtext,
              //         ),
                      
              //         // textcustomColor(
              //         //   color:MyColor.white,
              //         //   text: settingModelList.list.first.gametext,
              //         //   size: MyString.padding16
              //         // ),
              //         const SizedBox(
              //           height: MyString.padding36,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: MyString.padding12),
              //   child: ImageBox(
              //     hasChild: true,
              //     title: "MAX BET",
              //     textSize: MyString.padding36,
              //     sizeTitle: MyString.padding16,
              //     width: width,
              //     height: height * .15,
              //     asset: "asset/round.png",
              //     text: "${settingModelList.list.first.maxbet}",
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: MyString.padding12),
              //   child: ImageBox(
              //     hasChild: true,
              //     sizeTitle: MyString.padding16,
              //     title: "BUY IN AT",
              //     textSize: MyString.padding36,
              //     width: width,
              //     height: height * .15,
              //     asset: "asset/round.png",
              //     text: "${settingModelList.list.first.buyin}",
              //   ),
              // ),
              // Container(
              //   width: width,
              //   height: height * .2,
              //   // color:MyColor.white,
              //   child:Text('buy in: ${settingModelList.list.first.buyin}',style:TextStyle(color:MyColor.white)),

              // ),
            ],
          ),
        );
      },
    );
  }
}
