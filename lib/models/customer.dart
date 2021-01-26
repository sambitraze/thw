import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    Customer({
        this.id,
        this.cart,
        this.name,
        this.email,
        this.phone,
        this.latitude,
        this.longitude,
        this.address,
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    List<dynamic> cart;
    String name;
    String email;
    String phone;
    String latitude;
    String longitude;
    String address;
    String deviceToken;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"] == null ? null : json["_id"],
        cart: json["cart"] == null ? null : List<dynamic>.from(json["cart"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        address: json["address"] == null ? null : json["address"],
        deviceToken: json["deviceToken"] == null ? null : json["deviceToken"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "cart": cart == null ? null : List<dynamic>.from(cart.map((x) => x)),
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "address": address == null ? null : address,
        "deviceToken": deviceToken == null ? null : deviceToken,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
