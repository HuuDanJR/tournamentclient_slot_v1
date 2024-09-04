import 'package:flutter/material.dart';

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
