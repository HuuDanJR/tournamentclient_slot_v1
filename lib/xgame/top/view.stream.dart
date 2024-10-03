import 'dart:ui' as ui; // Import the correct library for Flutter Web
import 'package:flutter/material.dart';
import 'dart:html' as html; // This is needed for embedding HTML elements

class IframeWidget extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final int index; // Add an index to differentiate each iframe

  IframeWidget({Key? key, required this.url, required this.index,required this.width,required this.height})
      : super(key: key) {
    // Generate a unique viewType based on the index
    final viewType = 'iframe-html-$index';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => html.IFrameElement()
         ..width = '${width.toInt()}'  // Convert to string
        ..height = '${height.toInt()}' // Convert to string
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

// import 'dart:html' as html;
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:js/js.dart'; // Import JavaScript interop support for error handling

// class IframeWidget extends StatefulWidget {
//   final String url;
//   final int index;
//   final double width;
//   final double height;

//   const IframeWidget({Key? key, required this.url, required this.index,required this.width,required this.height})
//       : super(key: key);

//   @override
//   _IframeWidgetState createState() => _IframeWidgetState();
// }

// class _IframeWidgetState extends State<IframeWidget> {
//   bool _hasError = false;

//   @override
//   void initState() {
//     super.initState();

//     // Generate a unique viewType based on the index
//     final viewType = 'iframe-html-${widget.index}';

//     // Register the iframe element
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       viewType,
//       (int viewId) {
//         final iframe = html.IFrameElement()
//           ..width = '640'
//           ..height = '480'
//           ..src = widget.url
//           ..style.border = 'none';

//         // Call JS function to detect iframe errors
//         addErrorHandling(iframe, allowInterop((bool hasError) {
//           setState(() {
//             _hasError = hasError;
//           });
//         }));

//         return iframe;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       decoration: BoxDecoration(
//         color: _hasError
//             ? Colors.black
//             : Colors.transparent, // Black background on error
//       ),
//       child: _hasError
//           ? Center(
//               child: Text(
//                 'Failed to load URL: ${widget.url}',
//                 style: const TextStyle(color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//             )
//           : HtmlElementView(viewType: 'iframe-html-${widget.index}'),
//     );
//   }
// }

// // Define a JavaScript interop function to handle iframe error events
// @JS()
// external void addErrorHandling(html.IFrameElement iframe, Function callback);

// // JavaScript code to inject iframe error handling
// @JS('addErrorHandling')
// void _jsAddErrorHandling(html.IFrameElement iframe, Function callback) {
//   iframe.onError.listen((_) => callback(true));
//   iframe.onLoad.listen((_) => callback(false));
// }
