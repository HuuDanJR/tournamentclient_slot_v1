import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
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
        child: hasChild ==false ?  
          textcustomColorBold(
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
            fontWeight: FontWeight.w600, // Non-bold for first text
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



Widget ImageBoxNoText({
  required double textSize,
  required double width,required double height, required String asset, required String text}) {
  return Container(
    alignment: Alignment.center,
    width: width,
    height: height,
    decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.contain,
        )),
        child: 
        Text(
          text, // Second text
          style: TextStyle(
            color: MyColor.yellowMain,
            fontSize: textSize,
            fontWeight: FontWeight.bold, // Bold for second text
          ),
          textAlign: TextAlign.center,
        ),
  );
}









Widget ImageBoxTitle({
  required double textSize,
  required bool hasChild,
  String? title,
  double? sizeTitle,
  required double width,required double height, required String asset, required String text}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
              "$title", // First text
              style: TextStyle(
                color: MyColor.white,
                fontSize: sizeTitle,
                fontWeight: FontWeight.w600, // Non-bold for first text
              ),
              textAlign: TextAlign.center, // Center align if needed
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false, // Controls the height behavior
                applyHeightToLastDescent: false,
              ),
        ),
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
            child: hasChild ==false ?  
              textcustomColorBold(
                text: text,
                color: MyColor.yellowMain,
                size: textSize,
              ) 
            : 
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
      ),
    ],
  );
}



Widget imageBoxTitleWidget({
  // required double textSize,
  required String? title,
  required bool? drop,
  required Widget? widgetDrop,
  double? sizeTitle,
  required widget,
  required double width,
  required double height, required String asset, }) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
                "$title", // First text
                style: TextStyle(
                  color: MyColor.white,
                  fontSize: sizeTitle,
                  fontWeight: FontWeight.w700, // Non-bold for first text
                ),
                textAlign: TextAlign.center, // Center align if needed
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false, // Controls the height behavior
                  applyHeightToLastDescent: false,
                ),
          ),
        
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
              child:  widget
        ),
        drop==false ? Container(height: 0,): widgetDrop!
          // Text(
          //       "JP Dropped", // First text
          //       style: TextStyle(
          //         color: MyColor.white,
          //         fontSize: sizeTitle,
          //         fontWeight: FontWeight.w600, // Non-bold for first text
          //       ),
          //       textAlign: TextAlign.center, // Center align if needed
          //       textHeightBehavior: const TextHeightBehavior(
          //         applyHeightToFirstAscent: false, // Controls the height behavior
          //         applyHeightToLastDescent: false,
          //       ),
          // ),
          
      ],
    ),
  );
}



Widget imageBoxChild({
  required Widget child,
  required Widget subChild,
  required double width,required double height, required String asset, }) {
  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.all(MyString.padding08),
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
