import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItem {
    MenuItem({
        this.id,
        this.isVeg,
        this.itemName,
        this.itemType,
        this.price,
        this.ratting,
        this.url,
    });

    String id;
    bool isVeg;
    String itemName;
    String itemType;
    String price;
    int ratting;
    String url;

    factory MenuItem.fromsnapshot(QueryDocumentSnapshot json) => MenuItem(
        id: json["Id"] == null ? null : json["Id"],
        isVeg: json["Is_Veg"] == null ? null : json["Is_Veg"],
        itemName: json["Item_Name"] == null ? null : json["Item_Name"],
        itemType: json["Item_Type"] == null ? null : json["Item_Type"],
        price: json["Price"] == null ? null : json["Price"],
        ratting: json["Ratting"] == null ? null : json["Ratting"],
        url: json["url"] == null ? null : json["url"],
    );

    // Map<String, dynamic> toJson() => {
    //     "Id": id == null ? null : id,
    //     "Is_Veg": isVeg == null ? null : isVeg,
    //     "Item_Name": itemName == null ? null : itemName,
    //     "Item_Type": itemType == null ? null : itemType,
    //     "Price": price == null ? null : price,
    //     "Ratting": ratting == null ? null : ratting,
    //     "url": url == null ? null : url,
    // };
}
