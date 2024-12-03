// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
    bool status;
    String message;
    int totalResult;
    List<DeviceModelData> data;

    DeviceModel({
        required this.status,
        required this.message,
        required this.totalResult,
        required this.data,
    });

    factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        status: json["status"],
        message: json["message"],
        totalResult: json["totalResult"],
        data: List<DeviceModelData>.from(json["data"].map((x) => DeviceModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalResult": totalResult,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DeviceModelList{
    final List<DeviceModelData> list;

  DeviceModelList({required this.list});
  factory DeviceModelList.fromJson(List<dynamic> json) {
    List<DeviceModelData> list =json.map((data) => DeviceModelData.fromJson(data)).toList();
    return DeviceModelList(list: list);
  }
}

class DeviceModelData {
    String id;
    String deviceId;
    String deviceName;
    String deviceInfo;
    DateTime createdAt;
    int v;

    DeviceModelData({
        required this.id,
        required this.deviceId,
        required this.deviceName,
        required this.deviceInfo,
        required this.createdAt,
        required this.v,
    });

    factory DeviceModelData.fromJson(Map<String, dynamic> json) => DeviceModelData(
        id: json['_id'] as String,
        deviceId: json['deviceId'] as String, // Ensure this matches the backend data
        deviceName: json['deviceName'] as String,
        deviceInfo: json['deviceInfo'] as String,
        createdAt: DateTime.parse(json['createdAt']),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceId": deviceId,
        "deviceName": deviceName,
        "deviceInfo": deviceInfo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
