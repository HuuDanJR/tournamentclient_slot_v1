import 'package:flutter/material.dart';
import 'package:tournament_client/lib/models/deviceModel.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/xgame/bottom/widget/image.box.dart';

class GameSettingNumberPage extends StatefulWidget {
  final SocketManager socketManager;
  final String selectedNumber;
  final String uniqueId;
  final double width;
  final double height;
  const GameSettingNumberPage({
    required this.socketManager,
    required this.width,
    required this.uniqueId,
    required this.height,
    required this.selectedNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<GameSettingNumberPage> createState() => _GameSettingNumberPageState();
}

class _GameSettingNumberPageState extends State<GameSettingNumberPage> {
  @override
  void initState() {
    debugPrint("Init Device");
    widget.socketManager.emitDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: SocketManager().dataStreamDevice,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  const Center(child:CircularProgressIndicator());
        }
        else if (snapshot.hasError ) {
          return const Center(child: Icon(Icons.error, ));
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Icon(Icons.error, ));
        }

        try {
          // Parse data into DeviceModelList
          DeviceModelList deviceModelList = DeviceModelList.fromJson(snapshot.data!);
          // Check if uniqueId matches any deviceId
          // Find the matching device
          DeviceModelData? matchedDevice = deviceModelList.list.firstWhere((device) => device.deviceId == widget.uniqueId, ) ;
          bool hasMatch = deviceModelList.list.any((device) => device.deviceId == widget.uniqueId);
          return
          hasMatch ? ImageBoxNoText(
                textSize: MyString.padding84,
                width: widget.width,
                height: widget.height,
                asset: "asset/circle.png",
                text: matchedDevice.deviceInfo,
                label: 'PLAYER') : const SizedBox();

        } catch (e) {
          debugPrint("Error parsing devices: $e");
          return const Center(child: Icon(Icons.error, color: MyColor.white));
        }
      },
    );
  }
}
