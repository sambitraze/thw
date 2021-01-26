
import 'dart:convert';

DeliveryBy deliveryByFromJson(String str) => DeliveryBy.fromJson(json.decode(str));

String deliveryByToJson(DeliveryBy data) => json.encode(data.toJson());

class DeliveryBy {
    DeliveryBy({
        this.latitude,
        this.longitude,
        this.blocked,
        this.assigned,
        this.monthly,
        this.monthlyreset,
        this.completed,
        this.id,
        this.name,
        this.email,
        this.phone,
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String latitude;
    String longitude;
    bool blocked;
    String assigned;
    String monthly;
    bool monthlyreset;
    String completed;
    String id;
    String name;
    String email;
    String phone;
    dynamic deviceToken;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory DeliveryBy.fromJson(Map<String, dynamic> json) => DeliveryBy(
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        blocked: json["blocked"] == null ? null : json["blocked"],
        assigned: json["assigned"] == null ? null : json["assigned"],
        monthly: json["monthly"] == null ? null : json["monthly"],
        monthlyreset: json["monthlyreset"] == null ? null : json["monthlyreset"],
        completed: json["completed"] == null ? null : json["completed"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        deviceToken: json["deviceToken"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "blocked": blocked == null ? null : blocked,
        "assigned": assigned == null ? null : assigned,
        "monthly": monthly == null ? null : monthly,
        "monthlyreset": monthlyreset == null ? null : monthlyreset,
        "completed": completed == null ? null : completed,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "deviceToken": deviceToken,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
