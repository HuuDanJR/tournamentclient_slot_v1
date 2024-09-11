import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tournament_client/xpage/home/home.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/utils/functions.dart';
import 'package:tournament_client/lib/bar_chart_race.dart';
import 'package:tournament_client/utils/detect_resolution.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';


class HomeRealTimePage extends StatefulWidget {
  HomeRealTimePage({
    Key? key,
    required this.url,
    required this.selectedIndex,
    required this.title,
  }) : super(key: key);

  final String title;
  int? selectedIndex;
  final String url;

  @override
  State<HomeRealTimePage> createState() => _HomeRealTimePageState();
}

class _HomeRealTimePageState extends State<HomeRealTimePage> {
  late StreamController<List<Map<String, dynamic>>> streamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  late final SocketManager mySocket = SocketManager();

  @override
  void initState() {
    super.initState();
    mySocket.initSocket();
    mySocket.dataStream.listen((List<Map<String, dynamic>> newData) {
      
    });

  }

  @override
  void dispose() {
    mySocket.disposeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top:kIsWeb? MyString.TOP_PADDING_TOPRAKINGREALTIME : 0.0),
        child: SafeArea(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: mySocket.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Map<String, dynamic>>? dataList = snapshot.data;
                final List<String> member = dataList![0]['member'].cast<String>();
                final List<dynamic> rawData = dataList[1]['data'];
                final List<List<double>> processData = rawData.map((entry) => entry is List<dynamic>? entry.map(toDoubleFunc).toList(): <double>[]).toList();
                if (snapshot.data!.isEmpty ||
                    snapshot.data == null ||
                    snapshot.data == []) {
                    return const Text('empty data');
                }
                return Stack(
                  children: [
                    BarChartRace(
                      selectedIndex: widget.selectedIndex,
                      index: detect(widget.selectedIndex!.toDouble(), processData.first),
                      data: convertData(processData),
                      initialPlayState: true,
                      framesPerSecond: 85.0,
                      framesBetweenTwoStates: 85,
                      spaceBetweenTwoRectangles:detectResolutionSpacing(input: processData.last.length),
                      rectangleHeight:detectResolutionHeight(input: processData.last.length),
                      numberOfRactanglesToShow: processData.last.length, // <= 10
                      offset_text:detectResolutionOffsetX(input: processData.last.length),
                      offset_title:detectResolutionOffsetX(input: processData.last.length),
                      title: "",
                      columnsLabel: member,
                      statesLabel: listLabelGenerate(),
                      titleTextStyle: const TextStyle(),
                    ),
                    Positioned(
                        bottom: 32,
                        right: 28,
                        child: widget.selectedIndex == MyString.DEFAULTNUMBER
                            ? Container()
                            : Text('YOU ARE PLAYER ${widget.selectedIndex}',
                                style: const TextStyle(
                                  color: MyColor.white,
                                  fontSize: 18,
                                ))),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: .5, color: MyColor.white),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
