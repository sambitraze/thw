// To parse this JSON data, do
//
//     final deviceToken = deviceTokenFromJson(jsonString);

import 'dart:convert';

List<DeviceToken> deviceTokenFromJson(String str) => List<DeviceToken>.from(json.decode(str).map((x) => DeviceToken.fromJson(x)));

String deviceTokenToJson(List<DeviceToken> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceToken {
    DeviceToken({
        this.id,
        this.user,
        this.devicetoken,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String user;
    String devicetoken;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory DeviceToken.fromJson(Map<String, dynamic> json) => DeviceToken(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        devicetoken: json["devicetoken"] == null ? null : json["devicetoken"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "devicetoken": devicetoken == null ? null : devicetoken,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
