import 'package:flutter/material.dart';
import 'package:tournament_client/widget/text.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';

class GameTime extends StatelessWidget {
  final SocketManager socketManager;
  const GameTime({
    required this.socketManager,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: 'Emit Data Time',
          child: const Icon(Icons.refresh),
          onPressed: () {
            socketManager.emitTime();
          }),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: SocketManager().dataStreamTime,
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
          }
        },
      ),
    );
  }
}
