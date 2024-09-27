import 'dart:ui' as ui; // Import the correct library for Flutter Web
import 'package:flutter/material.dart';
import 'dart:html' as html; // This is needed for embedding HTML elements

class IframeWidget extends StatelessWidget {
  final String url;
  final int index; // Add an index to differentiate each iframe

  IframeWidget({Key? key, required this.url, required this.index}) : super(key: key) {
    // Generate a unique viewType based on the index
    final viewType = 'iframe-html-$index'; 

    // Register a unique factory for each iframe
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => html.IFrameElement()
        ..width = '640'
        ..height = '480'
        ..src = url
        ..style.border = 'none',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use the unique viewType
    return HtmlElementView(viewType: 'iframe-html-$index');
  }
}