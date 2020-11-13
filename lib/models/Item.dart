// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    Item({
        this.id,
        this.isVeg,
        this.name,
        this.category,
        this.price,
        this.rating,
        this.photoUrl,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    bool isVeg;
    String name;
    String category;
    String price;
    String rating;
    String photoUrl;
    DateTime createdAt;
    DateTime updatedAt;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        isVeg: json["isVeg"] == null ? null : json["isVeg"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        price: json["price"] == null ? null : json["price"],
        rating: json["rating"] == null ? null : json["rating"],
        photoUrl: json["photoUrl"] == null ? null : json["photoUrl"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "isVeg": isVeg == null ? null : isVeg,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "price": price == null ? null : price,
        "rating": rating == null ? null : rating,
        "photoUrl": photoUrl == null ? null : photoUrl,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
