import 'dart:ui' as ui; // Import the correct library for Flutter Web
import 'package:flutter/material.dart';
import 'dart:html' as html; // This is needed for embedding HTML elements

class IframeWidget extends StatelessWidget {
  final String url;
  IframeWidget({Key? key,required this.url}) : super(key: key) {
    // final String urlString =
    //     "https://viewer.millicast.com?streamId=sLbkP2/OBS&play=false&volume=false&pip=false&cast=false&liveBadge=false&userCount=false&disableSettings=true";

    ui.platformViewRegistry.registerViewFactory(
      'iframe-html',
      (int viewId) => html.IFrameElement()
        ..width = '640'
        ..height = '480'
        ..src = url
        ..style.border = 'none',
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(viewType: 'iframe-html');
  }
}
