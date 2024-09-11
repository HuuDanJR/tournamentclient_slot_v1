import 'package:flutter/material.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';

class GameSettingPage extends StatefulWidget {
  const GameSettingPage({
    Key? key,
  }) : super(key: key);

  @override
  _GameSettingPageState createState() => _GameSettingPageState();
}

class _GameSettingPageState extends State<GameSettingPage> {
  late final socketManager = SocketManager();

  @override
  void initState() {
    super.initState();
    debugPrint('Game Setting Init');
    socketManager.initSocket();
    socketManager.dataStreamSetting
        .listen((List<Map<String, dynamic>> newData) {
      debugPrint('data stream setting : $newData');
    });
  }

  @override
  void dispose() {
    socketManager.disposeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
            socketManager.emitSetting();
      }),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: SocketManager().dataStreamSetting,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return textcustom(text: 'error ${snapshot.error}');
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              snapshot.data == []) {
            return Container(
              child: Text('no data'),
            );
          } else {
            List<Map<String, dynamic>>? data = snapshot.data;
            return Text(data.toString());
            // if (data == null || data.isEmpty) {
            //   return Container();
            // }
            // return Text('${data.first}');
          }
        },
      ),
    );
  }
}
