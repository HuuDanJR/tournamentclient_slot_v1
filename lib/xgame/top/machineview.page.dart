import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/xgame/top/view.stream.dart';

class MachineViewPage extends StatelessWidget {
  final double width;
  final double height;
  const MachineViewPage({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = MyString.padding08;
    final heightItem = height / 2;
    final widthItem = width / 4 - padding * 2;

    final List<String> urlList = [
      "https://viewer.millicast.com?streamId=sLbkP2/OBS&play=false&volume=false&pip=false&cast=false&liveBadge=false&userCount=false&disableSettings=true",
      "https://viewer.millicast.com?streamId=sLbkP2/OBS2&play=false&volume=false&fullscreen=false&pip=false&cast=false&liveBadge=false&userCount=false&disableSettings=true",
      "",
      "",
      "",
      "",
      "",
      "",
    ];

    // Calculate number of rows (each row contains 4 items)
    final int totalRows = (urlList.length / 4).ceil();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MyString.padding08),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Generate rows based on totalRows
          ...List.generate(
            totalRows,
            (rowIndex) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (colIndex) {
                final itemIndex = rowIndex * 4 + colIndex;
                
                // Check if we have a corresponding URL for this item
                if (itemIndex < urlList.length) {
                  return MachineViewItem(
                    heightItem: heightItem,
                    widthItem: widthItem,
                    title: "PLAYER ${itemIndex + 1}",
                    active: urlList[itemIndex].isNotEmpty, // Check if URL exists
                    url: urlList[itemIndex], // Set the URL for the item
                  );
                } else {
                  return SizedBox(
                    width: widthItem,
                    height: heightItem,
                  ); // Empty space if there are fewer items than slots
                }
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget MachineViewItem(
      {required double widthItem,
      required double heightItem,
      required bool active,
      required String url,
      required String title}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          width: widthItem,
          height: heightItem * .1,
          child: textcustomColor(
            text: title,
            color: MyColor.white,
          ),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: MyColor.yellowMain,
              width: MyString.padding02,
            )),
            width: widthItem,
            height: heightItem * .9,
            child: active == true
                ? IframeWidget(
                    url: url,
                  )
                : Container())
      ],
    );
  }
}
