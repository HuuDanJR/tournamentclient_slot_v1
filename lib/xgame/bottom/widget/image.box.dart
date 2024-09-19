import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/widget/text.dart';

Widget ImageBox({
  required double textSize,
  required bool hasChild,
  String? title,
  double? sizeTitle,
  required double width,required double height, required String asset, required String text}) {
  return Container(
    // margin:const EdgeInsets.symmetric(horizontal:MyString.padding12),
    alignment: Alignment.center,
    width: width,
    height: height,
    decoration: BoxDecoration(
        // color: MyColor.whiteOpacity,
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.contain,
        )),
    child: hasChild ==false ?  textcustomColorBold(
        text: text,
        color: MyColor.yellowMain,
        size: textSize,
        ) 
        : 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
      "$title", // First text
      style: TextStyle(
        color: MyColor.white,
        fontSize: sizeTitle,
        fontWeight: FontWeight.normal, // Non-bold for first text
      ),
      textAlign: TextAlign.center, // Center align if needed
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false, // Controls the height behavior
        applyHeightToLastDescent: false,
      ),
    ),
    Text(
      text, // Second text
      style: TextStyle(
        color: MyColor.yellow_bg,
        fontSize: textSize,
        fontWeight: FontWeight.bold, // Bold for second text
      ),
      textAlign: TextAlign.center,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
    ),
          ],),
  );
}





Widget ImageBoxChild({
  required Widget child,
  required Widget subChild,
  required double width,required double height, required String asset, }) {
  return Stack(
    children: [
      Container(
        // margin:const EdgeInsets.symmetric(horizontal:MyString.padding12),
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
            // color: MyColor.whiteOpacity,
            image: DecorationImage(
              image: AssetImage(asset),
              fit: BoxFit.contain,
            )),
        child: Align(
          alignment: Alignment.center,
          child:child)
      ),
      Positioned.fill(
        child: Positioned(
          child: Align(
            alignment: Alignment.centerLeft, // Align subChild to the center
            child: Row(
              children: [
                SizedBox(width: width/5,),
                subChild,
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
