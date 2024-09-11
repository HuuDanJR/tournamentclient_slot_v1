import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';

Widget mytextfield({hint,controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(hintText: "$hint"),
  );
}
Widget mytextFieldTitle({hint,required TextEditingController? controller,required bool? enable,required TextInputType? textinputType,required String? label,String? text}) {
  if (controller != null && text != null) {
    controller.text = text; // Set the initial value
  }
  return TextField(
    keyboardType: textinputType,
    controller: controller,
    enabled: enable,
    decoration: InputDecoration(hintText: "$hint",labelText: label),
  );
}


Widget mytextFieldTitleSizeIcon({
  required double width,
  required Icon icon, 
  String? hint,
  required TextEditingController? controller,
  required bool? enable,
  required TextInputType? textinputType,
  required String? label,
  String? text
}) {
  // Update the controller's text only if it's different from the current value
  // if (controller != null && text != null && controller.text != text) {
  //   controller.text = text;
  // }

  return Container(
    margin: const EdgeInsets.only(bottom: MyString.padding08),
    decoration: BoxDecoration(
      color: MyColor.grey_tab_opa,
      borderRadius: BorderRadius.circular(MyString.padding16),
    ),
    width: width,
    child: TextField(
      keyboardType: textinputType,
      controller: controller,
      enabled: enable,
      decoration: InputDecoration(
        prefixIcon: icon,
        border: InputBorder.none,
        fillColor: MyColor.grey_tab,
        hoverColor: MyColor.bedge,
        hintText: hint,
        labelText: label,
      ),
    ),
  );
}
