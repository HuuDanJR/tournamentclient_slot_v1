import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._();
  factory SocketManager() {
    return _instance;
  }

  IO.Socket? _socket;
  late StreamController<List<Map<String, dynamic>>> _streamController;
  late StreamController<List<Map<String, dynamic>>> _streamController2;
  late StreamController<List<Map<String, dynamic>>> _streamControllerView;
  late StreamController<List<Map<String, dynamic>>> _streamControllerSetting;

  IO.Socket? get socket => _socket;

  Stream<List<Map<String, dynamic>>> get dataStream => _streamController.stream;
  Stream<List<Map<String, dynamic>>> get dataStream2 =>
      _streamController2.stream;
  Stream<List<Map<String, dynamic>>> get dataStreamView =>
      _streamControllerView.stream;
  Stream<List<Map<String, dynamic>>> get dataStreamSetting =>
      _streamControllerSetting.stream;

  SocketManager._() {
    _streamController =
        StreamController<List<Map<String, dynamic>>>.broadcast();
    _streamController2 =
        StreamController<List<Map<String, dynamic>>>.broadcast();
    _streamControllerView =
        StreamController<List<Map<String, dynamic>>>.broadcast();
    _streamControllerSetting =
        StreamController<List<Map<String, dynamic>>>.broadcast();
  }

  void initSocket() {
    debugPrint('initSocket');
    _socket = IO.io(MyString.BASEURL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    _socket?.on('eventFromServer', (data) {
      // print('eventFromServer log: $data');
      processData(data);
    });
    _socket?.on('eventFromServerMongo', (data) {
      // print('eventFromServerMongo log: $data');
      processData2(data);
    });

    //socket toggle view
    _socket?.on('eventFromServerToggle', (data) {
      // debugPrint('eventFromServerToggle log: $data');
      processDataToggle(data);
    });

    //SETTING VIEW
    _socket?.on('eventSetting', (data) {
      debugPrint('eventSetting');
      debugPrint('eventSetting log: $data');
      processDataSetting(data);
    });

    _socket?.connect();
  }

  void connectSocket() {
    _socket?.connect();
  }

  void disposeSocket() {
    _socket?.disconnect();
    _socket = null;
  }

//process data setting
  void processDataSetting(dynamic data) {
    debugPrint('processDataSetting');
    for (var jsonData in data) {
      try {
        // Create a Map to represent the display data
        Map<String, dynamic> data = {
          "remaintime": jsonData['remaintime'],
          "remaingame": jsonData['remaingame'],
          "minbet": jsonData['minbet'],
          "maxbet": jsonData['maxbet'],
          "run": jsonData['run'],
          "lastupdate": jsonData['lastupdate'],
          "gamenumber": jsonData['gamenumber'],
          "roundtext": jsonData['roundtext'],
          "gametext": jsonData['gametext'],
          "buyin": jsonData['buyin']
        };
        _streamControllerSetting.add([data]);
      } catch (e) {
        debugPrint('Error parsing data setting: $e');
      }
    }
  }

  void processData(dynamic data) {
    if (data is List<dynamic> && data.isNotEmpty) {
      if (data[0] is List<dynamic>) {
        List<dynamic> memberList = data[0];
        List rawData = data;
        List<List<dynamic>> formattedData = [memberList, ...rawData];
        List<Map<String, dynamic>> resultData = [];
        List<String> memberListAsString =
            memberList.map((member) => member.toString()).toList();

        for (int i = 1; i < formattedData.length; i++) {
          Map<String, dynamic> entry = {
            'member': memberListAsString,
            'data': formattedData[i].map((entry) {
              if (entry is num) {
                return entry.toDouble();
              }
              return entry;
            }).toList(),
          };
          resultData.add(entry);
        }
        _streamController.add(resultData);
      }
    }
  }

  void processData2(dynamic data) {
    final Map<String, dynamic>? jsonData = data as Map<String, dynamic>?;

    if (jsonData != null) {
      final List<dynamic>? dataList = jsonData['data'] as List<dynamic>?;
      final List<dynamic>? nameList = jsonData['name'] as List<dynamic>?;
      final List<dynamic>? numberList = jsonData['number'] as List<dynamic>?;
      final List<dynamic>? timeList = jsonData['time'] as List<dynamic>?;

      if (dataList != null && nameList != null) {
        final Map<String, dynamic> finalFormattedData = {
          'data': dataList,
          'name': nameList,
          'number': numberList,
          'time': timeList,
        };
        List<Map<String, dynamic>> listOfMaps = [finalFormattedData];
        _streamController2.add(listOfMaps);
      }
    }
  }

  void processDataToggle(dynamic data) {
    for (var jsonData in data) {
      try {
        // Parse the createdAt field as a DateTime object
        DateTime createdAt = DateTime.parse(jsonData['createdAt']);
        // Create a Map to represent the display data
        Map<String, dynamic> displayData = {
          // '_id': jsonData['_id'].toString(), // Convert ObjectId to string
          // 'id': jsonData['id'],
          'name': jsonData['name'],
          'enable': jsonData['enable'],
          'content': jsonData['content'],
          // 'createdAt': createdAt,
        };
        _streamControllerView.add([displayData]);
      } catch (e) {
        debugPrint('Error parsing datetime: $e');
      }
    }
  }

  void emitEventFromClient() {
    _socket?.emit('eventFromClient');
  }

  void emitEventFromClient2() {
    _socket?.emit('eventFromClient2');
  }

  void emitEventFromClientForce() {
    socket!.emit('eventFromClient_force');
  }

  Future<void> emitEventFromClient2Force() async {
    socket!.emit('eventFromClient2_force');
  }

  void emitEventChangeLimitTopRanking(newLimit) {
    // Ensure newLimit is a valid value before emitting the event
    if (newLimit != 'undefined' && newLimit != null) {
      socket!.emit('changeLimitTopRanking', {newLimit});
    } else {
      debugPrint('Invalid newLimit value');
    }
  }

  void emitEventChangeLimitRealTimeRanking(newLimit) {
    // Ensure newLimit is a valid value before emitting the event
    if (newLimit != 'undefined' && newLimit != null) {
      socket!.emit('changeLimitRealTimeRanking', {newLimit});
    } else {
      debugPrint('Invalid newLimit value');
    }
  }

  //toglge view data or top ranking
  void emitToggleClient() {
    socket!.emit('emitToggleDisplay');
  }

  //togge view to see only real ranking or both
  void emitToggleRealTopClient() {
    socket!.emit('emitToggleDisplayRealTop');
  }




    //togge view to see only real ranking or both
  void emitSetting() {
    socket!.emit('emitSetting');
  }
}
